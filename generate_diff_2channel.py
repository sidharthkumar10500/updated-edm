# Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
#
# This work is licensed under a Creative Commons
# Attribution-NonCommercial-ShareAlike 4.0 International License.
# You should have received a copy of the license along with this
# work. If not, see http://creativecommons.org/licenses/by-nc-sa/4.0/

"""Generate random images using the techniques described in the paper
"Elucidating the Design Space of Diffusion-Based Generative Models"."""

import os
import re
import click
import tqdm
import pickle
import numpy as np
import torch
import PIL.Image
import dnnlib
from torch_utils import distributed as dist

# next 3 lines only if you want to debug with only 1 gpu
import os 
os.environ["CUDA_DEVICE_ORDER"]="PCI_BUS_ID"   # see issue #152
os.environ["CUDA_VISIBLE_DEVICES"]="3" # for debugging purposes to only run on one gpu


# Proposed EDM sampler (Algorithm 2).

def edm_sampler(
    net, latents, class_labels=None, randn_like=torch.randn_like,
    num_steps=18, sigma_min=0.002, sigma_max=80, rho=7,
    S_churn=0, S_min=0, S_max=float('inf'), S_noise=1,  logging=False
):
    # Adjust noise levels based on what's supported by the network.
    sigma_min = max(sigma_min, net.sigma_min)
    sigma_max = min(sigma_max, net.sigma_max)

    # Time step discretization.
    step_indices = torch.arange(num_steps, dtype=torch.float64, device=latents.device)
    t_steps = (sigma_max ** (1 / rho) + step_indices / (num_steps - 1) * (sigma_min ** (1 / rho) - sigma_max ** (1 / rho))) ** rho
    t_steps = torch.cat([net.round_sigma(t_steps), torch.zeros_like(t_steps[:1])]) # t_N = 0

    # Main sampling loop.
    x_next = latents.to(torch.float64) * t_steps[0]
    ksp_data = torch.load('ksp_undersampled.pt')
    kspace_undersampled= ksp_data['ksp'].cuda()
    mask = ksp_data['mask'].cuda()
    GT = ksp_data['GT'].cuda()
    ##x_next = _ifft(kspace_undersampled)
    x_stack=[]
    for i, (t_cur, t_next) in enumerate(zip(t_steps[:-1], t_steps[1:])): # 0, ..., N-1
        x_cur = x_next

        # Increase noise temporarily.
        gamma = min(S_churn / num_steps, np.sqrt(2) - 1) if S_min <= t_cur <= S_max else 0
        t_hat = net.round_sigma(t_cur + gamma * t_cur)
        x_hat = x_cur + (t_hat ** 2 - t_cur ** 2).sqrt() * S_noise * randn_like(x_cur)

        # measure grad function
        Ax_hat = mask[None,None,...]*_fft(x_cur)
        DC_term = kspace_undersampled[None,None,...] - Ax_hat # Data consistency term
        meas_grad = _ifft(DC_term)
        meas_grad = torch.abs(meas_grad / torch.linalg.norm(meas_grad, dim=(-1, -2), keepdims=True))
        

        # Euler step.
        denoised = net(x_hat, t_hat, class_labels).to(torch.float64)
        d_cur = (x_hat - denoised) / t_hat
        meas_grad = meas_grad * torch.linalg.norm(d_cur, dim=(-1, -2), keepdims=True)
        x_next = x_hat + (t_next - t_hat) * (d_cur + meas_grad)

        if logging:
            x_stack.append(x_next.cpu().numpy())
        # # Apply 2nd order correction.
        if i < num_steps - 1:
            denoised = net(x_next, t_next, class_labels).to(torch.float64)
            d_prime = (x_next - denoised) / t_next
            x_next = x_hat + (t_next - t_hat) * (0.5 * d_cur + 0.5 * d_prime)
        if i % 10 == 0:
            import matplotlib.pyplot as plt
            print(i)
            plt.figure(figsize=(12,10)); plt.imshow(np.abs(x_next.squeeze().cpu().numpy()),cmap='gray'); plt.tight_layout(); plt.savefig('Debug.png',dpi=100); plt.close()

    if logging:
        return x_next, np.asarray(x_stack)
    else:
        return x_next

#### helper functions to get the normalization going on
def normalize(x, x_min, x_max):
    """
    Scales x to appx [-1, 1]
    """
    out = (x - x_min) / (x_max - x_min)
    return 2*out - 1

def unnormalize(x, x_min, x_max):
    """
    Takes input in appx [-1,1] and unscales it
    """
    out = (x + 1) / 2
    return out * (x_max - x_min) + x_min

#----------------------------------------------------------------------------
# Centered, orthogonal ifft in torch >= 1.7
import torch.fft as torch_fft
def _ifft(x):
    x = torch_fft.ifftshift(x, dim=(-2, -1))
    x = torch_fft.ifft2(x, dim=(-2, -1), norm='ortho')
    x = torch_fft.fftshift(x, dim=(-2, -1))
    return x


def adjoint(x, sens, mask, basis, K =1):
    x = x*mask
    x = torch_fft.ifftshift(x, dim=(-2, -1))
    x = torch_fft.ifft2(x, dim=(-2, -1), norm='ortho')
    x = torch_fft.fftshift(x, dim=(-2, -1))
    x = torch.sum(x*torch.conj(sens), axis=1)[:,None,...]
    x = torch.sum(x*basis[:,:K,:,:] ,dim=0)
    return x

def adjoint_coils(x, sens, mask):
    x = torch.sum(x, dim=0)
    mask = torch.sum(mask, dim=0)
    x = x*mask
    x = torch_fft.ifftshift(x, dim=(-2, -1))
    x = torch_fft.ifft2(x, dim=(-2, -1), norm='ortho')
    x = torch_fft.fftshift(x, dim=(-2, -1))
    x = torch.sum(x*torch.conj(sens.squeeze()), axis=0)
    return x

def forward(x, sens, mask, basis, K = 1):
    # x.shape = [1,K,256,256]
    # sens.shape = [1,7,256,256]
    # mask.shape = [80,1,256,256]
    # basis.shape = [80,80,1,1]
    x = torch.sum(x[None,:,:,:]*basis[:,:K,:,:] ,dim=1)[:,None,...]
    x = x*sens
    x = torch_fft.ifftshift(x, dim=(-2, -1))
    x = torch_fft.fft2(x, dim=(-2, -1), norm='ortho')
    x = torch_fft.fftshift(x, dim=(-2, -1))
    return x*mask


# Centered, orthogonal fft in torch >= 1.7
def _fft(x):
    x = torch_fft.ifftshift(x, dim=(-2, -1))
    x = torch_fft.fft2(x, dim=(-2, -1), norm='ortho')
    x = torch_fft.fftshift(x, dim=(-2, -1))
    return x
#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# Generalized ablation sampler, representing the superset of all sampling
# methods discussed in the paper.

def ablation_sampler(
    net, latents, class_labels=None, randn_like=torch.randn_like,
    num_steps=18, sigma_min=None, sigma_max=None, rho=7,
    solver='heun', discretization='edm', schedule='linear', scaling='none',
    epsilon_s=1e-3, C_1=0.001, C_2=0.008, M=1000, alpha=1,
    S_churn=0, S_min=0, S_max=float('inf'), S_noise=1,
):
    assert solver in ['euler', 'heun']
    assert discretization in ['vp', 've', 'iddpm', 'edm']
    assert schedule in ['vp', 've', 'linear']
    assert scaling in ['vp', 'none']

    # Helper functions for VP & VE noise level schedules.
    vp_sigma = lambda beta_d, beta_min: lambda t: (np.e ** (0.5 * beta_d * (t ** 2) + beta_min * t) - 1) ** 0.5
    vp_sigma_deriv = lambda beta_d, beta_min: lambda t: 0.5 * (beta_min + beta_d * t) * (sigma(t) + 1 / sigma(t))
    vp_sigma_inv = lambda beta_d, beta_min: lambda sigma: ((beta_min ** 2 + 2 * beta_d * (sigma ** 2 + 1).log()).sqrt() - beta_min) / beta_d
    ve_sigma = lambda t: t.sqrt()
    ve_sigma_deriv = lambda t: 0.5 / t.sqrt()
    ve_sigma_inv = lambda sigma: sigma ** 2

    # Select default noise level range based on the specified time step discretization.
    if sigma_min is None:
        vp_def = vp_sigma(beta_d=19.9, beta_min=0.1)(t=epsilon_s)
        sigma_min = {'vp': vp_def, 've': 0.02, 'iddpm': 0.002, 'edm': 0.002}[discretization]
    if sigma_max is None:
        vp_def = vp_sigma(beta_d=19.9, beta_min=0.1)(t=1)
        sigma_max = {'vp': vp_def, 've': 100, 'iddpm': 81, 'edm': 80}[discretization]

    # Adjust noise levels based on what's supported by the network.
    sigma_min = max(sigma_min, net.sigma_min)
    sigma_max = min(sigma_max, net.sigma_max)

    # Compute corresponding betas for VP.
    vp_beta_d = 2 * (np.log(sigma_min ** 2 + 1) / epsilon_s - np.log(sigma_max ** 2 + 1)) / (epsilon_s - 1)
    vp_beta_min = np.log(sigma_max ** 2 + 1) - 0.5 * vp_beta_d

    # Define time steps in terms of noise level.
    step_indices = torch.arange(num_steps, dtype=torch.float64, device=latents.device)
    if discretization == 'vp':
        orig_t_steps = 1 + step_indices / (num_steps - 1) * (epsilon_s - 1)
        sigma_steps = vp_sigma(vp_beta_d, vp_beta_min)(orig_t_steps)

    elif discretization == 've':
        orig_t_steps = (sigma_max ** 2) * ((sigma_min ** 2 / sigma_max ** 2) ** (step_indices / (num_steps - 1)))
        sigma_steps = ve_sigma(orig_t_steps)
    elif discretization == 'iddpm':
        u = torch.zeros(M + 1, dtype=torch.float64, device=latents.device)
        alpha_bar = lambda j: (0.5 * np.pi * j / M / (C_2 + 1)).sin() ** 2
        for j in torch.arange(M, 0, -1, device=latents.device): # M, ..., 1
            u[j - 1] = ((u[j] ** 2 + 1) / (alpha_bar(j - 1) / alpha_bar(j)).clip(min=C_1) - 1).sqrt()
        u_filtered = u[torch.logical_and(u >= sigma_min, u <= sigma_max)]
        sigma_steps = u_filtered[((len(u_filtered) - 1) / (num_steps - 1) * step_indices).round().to(torch.int64)]
    else:
        assert discretization == 'edm'
        sigma_steps = (sigma_max ** (1 / rho) + step_indices / (num_steps - 1) * (sigma_min ** (1 / rho) - sigma_max ** (1 / rho))) ** rho

    # Define noise level schedule.
    if schedule == 'vp':
        sigma = vp_sigma(vp_beta_d, vp_beta_min)
        sigma_deriv = vp_sigma_deriv(vp_beta_d, vp_beta_min)
        sigma_inv = vp_sigma_inv(vp_beta_d, vp_beta_min)
    elif schedule == 've':
        sigma = ve_sigma
        sigma_deriv = ve_sigma_deriv
        sigma_inv = ve_sigma_inv
    else:
        assert schedule == 'linear'
        sigma = lambda t: t
        sigma_deriv = lambda t: 1
        sigma_inv = lambda sigma: sigma

    # Define scaling schedule.
    if scaling == 'vp':
        s = lambda t: 1 / (1 + sigma(t) ** 2).sqrt()
        s_deriv = lambda t: -sigma(t) * sigma_deriv(t) * (s(t) ** 3)
    else:
        assert scaling == 'none'
        s = lambda t: 1
        s_deriv = lambda t: 0

    # Compute final time steps based on the corresponding noise levels.
    t_steps = sigma_inv(net.round_sigma(sigma_steps))
    t_steps = torch.cat([t_steps, torch.zeros_like(t_steps[:1])]) # t_N = 0

    # Sidharth:- Adding steps to do Diffusion posterior sampling (DPS) refer https://arxiv.org/pdf/2209.14687.pdf and https://arxiv.org/pdf/2206.00364.pdf appendix C
    # Eq 32, https://arxiv.org/pdf/2011.13456.pdf, song sde paper
    alpha_t = 0.5 * vp_beta_d * (t_steps ** 2)  +  vp_beta_min*t_steps
    alpha_t_bar = torch.cumprod(alpha_t, dim=0)

    # Main sampling loop.
    t_next = t_steps[0]
    x_next = latents.to(torch.float64) * (sigma(t_next) * s(t_next))
    K = 3# number of basis coefficients to be reconstructed
    ksp_data = torch.load('ksp_basis_data_basis.pt')
    kspace_undersampled= torch.permute(ksp_data['ksp'].cuda(), (3,2,0,1))
    mask = torch.permute(ksp_data['mask'].cuda() , (2,0,1))[:,None,...]
    sens = torch.permute(ksp_data['sens'].cuda(), (2,0,1))[None,...]
    basis = ksp_data['basis'].cuda()[:,:,None,None]
    alpha = torch.permute(ksp_data['alpha'].cuda() , (2,0,1))
    print(kspace_undersampled.shape, mask.shape, sens.shape, basis.shape)
    ##x_next = _ifft(kspace_undersampled)
    # for now inverse crime and will look into this later
    tt = adjoint(kspace_undersampled, sens, mask, basis, K=K)
    # inverse crime for now
    x_undersampled = alpha[0]# adjoint(kspace_undersampled, sens, mask, basis, K=K)
    scaling = torch.quantile(torch.abs(x_undersampled), 0.99)
    kspace_undersampled = kspace_undersampled/scaling

    x_undersampled_2channel = torch.view_as_real(alpha).squeeze()
    x_undersampled_2channel = torch.permute(x_undersampled_2channel, (0,3,1,2))

    x_stack=[]
    # norm_mins = torch.amin(x_undersampled, dim=(1,2,3), keepdim=True) #[N, 1, 1, 1]
    # norm_maxes = torch.amax(x_undersampled, dim=(1,2,3), keepdim=True) #[N, 1, 1, 1]
    latents_new = torch.randn([K, net.img_channels, net.img_resolution, net.img_resolution], device=latents.device)
    x_next = latents_new.to(torch.float64) * (sigma(t_next) * s(t_next))
    for i, (t_cur, t_next) in enumerate(zip(t_steps[:-1], t_steps[1:])): # 0, ..., N-1
        # without noise addition
        x_cur = x_next
        x_hat = x_cur.requires_grad_() #starting grad tracking with the noised img
        gamma = min(S_churn / num_steps, np.sqrt(2) - 1) if S_min <= sigma(t_cur) <= S_max else 0
        t_hat = sigma_inv(net.round_sigma(sigma(t_cur) + gamma * sigma(t_cur)))
        denoised = net(x_hat / s(t_hat), sigma(t_hat), class_labels).to(torch.float64)
        d_i = (sigma_deriv(t_cur)/sigma(t_cur) + s_deriv(t_cur)/s(t_cur))*x_cur - (sigma_deriv(t_cur)/sigma(t_cur)*s(t_cur))*denoised
        x_next = x_cur + (t_next-t_cur)*d_i

        # measure grad function and likelihood step from DPS paper method
        denoised_complex = torch.complex(denoised[:,0,...], denoised[:,1,...])
        Ax = forward(denoised_complex, sens, mask, basis, K=K)
        if i==0:print(i, torch.linalg.norm(kspace_undersampled))
        if i%10==0:
            print(i, torch.linalg.norm(Ax))
        DC_term = kspace_undersampled - Ax
        sse = torch.norm(DC_term)**2
        meas_grad = torch.autograd.grad(outputs=sse, inputs=x_cur)[0]
        meas_grad = meas_grad / torch.sqrt(sse)
        # likelihood_step_size = 7.5 # weighting to the likelihood grad
        likelihood_step_size = torch.tensor([7.5, 15, 20], device=x_next.device)
        x_next = x_next - (likelihood_step_size[:,None,None,None]) * meas_grad    
 
        x_next = x_next.detach()   # to free the computational graph after auto grad is called
        x_hat = x_hat.detach()
        if i%49==0:
            import matplotlib.pyplot as plt
            to_plot_data = x_next.squeeze().detach().cpu().numpy()
            plt.figure(figsize=(12,10)); 
            plt.subplot(1,3,1)
            plt.imshow(np.abs(to_plot_data[0,0,...] + 1j*to_plot_data[0,1,...]),cmap='gray'); 
            plt.subplot(1,3,2)
            plt.imshow(np.abs(to_plot_data[1,0,...] + 1j*to_plot_data[1,1,...]),cmap='gray'); 
            plt.subplot(1,3,3)
            plt.imshow(np.abs(to_plot_data[2,0,...] + 1j*to_plot_data[2,1,...]),cmap='gray'); 
            plt.tight_layout(); plt.savefig('Debug.png',dpi=100); plt.close()


    x_next_complex = torch.complex(x_next[:,0,...], x_next[:,1,...])#denoised[0,0,...] + 1j*denoised[0,1,...]
    x_next = adjoint(forward(x_next_complex, sens, torch.ones_like(mask), basis, K=K), sens, torch.ones_like(mask), basis, K=K)
    x_next = torch.permute(torch.view_as_real(x_next.squeeze()), (0,3,1,2))
    return x_next / torch.linalg.norm(x_next, dim=(-1, -2), keepdims=True) * torch.linalg.norm(x_undersampled_2channel, dim=(-1, -2), keepdims=True)

#----------------------------------------------------------------------------
# Wrapper for torch.Generator that allows specifying a different random seed
# for each sample in a minibatch.

class StackedRandomGenerator:
    def __init__(self, device, seeds):
        super().__init__()
        self.generators = [torch.Generator(device).manual_seed(int(seed) % (1 << 32)) for seed in seeds]

    def randn(self, size, **kwargs):
        assert size[0] == len(self.generators)
        return torch.stack([torch.randn(size[1:], generator=gen, **kwargs) for gen in self.generators])

    def randn_like(self, input):
        return self.randn(input.shape, dtype=input.dtype, layout=input.layout, device=input.device)

    def randint(self, *args, size, **kwargs):
        assert size[0] == len(self.generators)
        return torch.stack([torch.randint(*args, size=size[1:], generator=gen, **kwargs) for gen in self.generators])

#----------------------------------------------------------------------------
# Parse a comma separated list of numbers or ranges and return a list of ints.
# Example: '1,2,5-10' returns [1, 2, 5, 6, 7, 8, 9, 10]

def parse_int_list(s):
    if isinstance(s, list): return s
    ranges = []
    range_re = re.compile(r'^(\d+)-(\d+)$')
    for p in s.split(','):
        m = range_re.match(p)
        if m:
            ranges.extend(range(int(m.group(1)), int(m.group(2))+1))
        else:
            ranges.append(int(p))
    return ranges

#----------------------------------------------------------------------------

@click.command()
# @click.option('--network', 'network_pkl',  help='Network pickle filename', metavar='PATH|URL',                      type=str, required=True, default = '/home/sidharth/edm/training-runs/00017-edm_t2sh_data-uncond-ddpmpp-edm-gpus2-batch32-fp32-container_test/network-snapshot-004915.pkl')
@click.option('--network', 'network_pkl',  help='Network pickle filename', metavar='PATH|URL',                      type=str, required=True, default = '/home/sidharth/edm/training-runs/00020-edm_t2sh_data_2channel-uncond-ddpmpp-edm-gpus2-batch32-fp32-container_test/network-snapshot-003276.pkl')
@click.option('--outdir',                  help='Where to save the output images', metavar='DIR',                   type=str, required=True, default = 'out8_2channel_diff_weights')
@click.option('--seeds',                   help='Random seeds (e.g. 1,2,5-10)', metavar='LIST',                     type=parse_int_list, default='0', show_default=True)
@click.option('--subdirs',                 help='Create subdirectory for every 1000 seeds',                         is_flag=True)
@click.option('--class', 'class_idx',      help='Class label  [default: random]', metavar='INT',                    type=click.IntRange(min=0), default=None)
@click.option('--batch', 'max_batch_size', help='Maximum batch size', metavar='INT',                                type=click.IntRange(min=1), default=3, show_default=True)

@click.option('--steps', 'num_steps',      help='Number of sampling steps', metavar='INT',                          type=click.IntRange(min=1), default=300, show_default=True)
@click.option('--sigma_min',               help='Lowest noise level  [default: varies]', metavar='FLOAT',           type=click.FloatRange(min=0, min_open=True), default=0.002)
@click.option('--sigma_max',               help='Highest noise level  [default: varies]', metavar='FLOAT',          type=click.FloatRange(min=0, min_open=True), default=5)
@click.option('--rho',                     help='Time step exponent', metavar='FLOAT',                              type=click.FloatRange(min=0, min_open=True), default=7, show_default=True)
@click.option('--S_churn', 'S_churn',      help='Stochasticity strength', metavar='FLOAT',                          type=click.FloatRange(min=0), default=0, show_default=True)
@click.option('--S_min', 'S_min',          help='Stoch. min noise level', metavar='FLOAT',                          type=click.FloatRange(min=0), default=0, show_default=True)
@click.option('--S_max', 'S_max',          help='Stoch. max noise level', metavar='FLOAT',                          type=click.FloatRange(min=0), default='inf', show_default=True)
@click.option('--S_noise', 'S_noise',      help='Stoch. noise inflation', metavar='FLOAT',                          type=float, default=1, show_default=True)

@click.option('--solver',                  help='Ablate ODE solver', metavar='euler|heun',                          type=click.Choice(['euler', 'heun']), default = 'euler')
@click.option('--disc', 'discretization',  help='Ablate time step discretization {t_i}', metavar='vp|ve|iddpm|edm', type=click.Choice(['vp', 've', 'iddpm', 'edm']), default = 'vp')
@click.option('--schedule',                help='Ablate noise schedule sigma(t)', metavar='vp|ve|linear',           type=click.Choice(['vp', 've', 'linear']), default = 'vp')
@click.option('--scaling',                 help='Ablate signal scaling s(t)', metavar='vp|none',                    type=click.Choice(['vp', 'none']), default = 'vp')

def main(network_pkl, outdir, subdirs, seeds, class_idx, max_batch_size, device=torch.device('cuda'), **sampler_kwargs):
    """Generate random images using the techniques described in the paper
    "Elucidating the Design Space of Diffusion-Based Generative Models".

    Examples:

    \b
    # Generate 64 images and save them as out/*.png
    python generate.py --outdir=out --seeds=0-63 --batch=64 \\
        --network=https://nvlabs-fi-cdn.nvidia.com/edm/pretrained/edm-cifar10-32x32-cond-vp.pkl

    \b
    # Generate 1024 images using 2 GPUs
    torchrun --standalone --nproc_per_node=2 generate.py --outdir=out --seeds=0-999 --batch=64 \\
        --network=https://nvlabs-fi-cdn.nvidia.com/edm/pretrained/edm-cifar10-32x32-cond-vp.pkl
    """
    dist.init()
    num_batches = ((len(seeds) - 1) // (max_batch_size * dist.get_world_size()) + 1) * dist.get_world_size()
    all_batches = torch.as_tensor(seeds).tensor_split(num_batches)
    rank_batches = all_batches[dist.get_rank() :: dist.get_world_size()]

    # Rank 0 goes first.
    if dist.get_rank() != 0:
        torch.distributed.barrier()

    # Load network.
    dist.print0(f'Loading network from "{network_pkl}"...')
    with dnnlib.util.open_url(network_pkl, verbose=(dist.get_rank() == 0)) as f:
        net = pickle.load(f)['ema'].to(device)

    # Other ranks follow.
    if dist.get_rank() == 0:
        torch.distributed.barrier()

    # Loop over batches.
    dist.print0(f'Generating {len(seeds)} images to "{outdir}"...')
    for batch_seeds in tqdm.tqdm(rank_batches, unit='batch', disable=(dist.get_rank() != 0)):
        torch.distributed.barrier()
        batch_size = len(batch_seeds)
        if batch_size == 0:
            continue

        # Pick latents and labels.
        rnd = StackedRandomGenerator(device, batch_seeds)
        latents = rnd.randn([batch_size, net.img_channels, net.img_resolution, net.img_resolution], device=device)
        class_labels = None
        if net.label_dim:
            class_labels = torch.eye(net.label_dim, device=device)[rnd.randint(net.label_dim, size=[batch_size], device=device)]
        if class_idx is not None:
            class_labels[:, :] = 0
            class_labels[:, class_idx] = 1

        # Generate images.
        sampler_kwargs = {key: value for key, value in sampler_kwargs.items() if value is not None}
        have_ablation_kwargs = any(x in sampler_kwargs for x in ['solver', 'discretization', 'schedule', 'scaling'])
        sampler_fn = ablation_sampler if have_ablation_kwargs else edm_sampler
        images = sampler_fn(net, latents, class_labels, randn_like=rnd.randn_like, **sampler_kwargs)

        # Save images.
        images_np = (images * 127.5 + 128).clip(0, 255).to(torch.uint8).permute(0, 2, 3, 1).cpu().numpy()
        # numpy images without the 255 noramlize that is used for the png files
        images_np_without_normalize = images.permute(0, 2, 3, 1).cpu().numpy()
        for seed, image_np in zip(batch_seeds, images_np):
            image_dir = os.path.join(outdir, f'{seed-seed%1000:06d}') if subdirs else outdir
            os.makedirs(image_dir, exist_ok=True)
            image_path = os.path.join(image_dir, f'{seed:06d}.png')
            np.save(os.path.join(image_dir, f'{seed:06d}.npy'), images_np_without_normalize)
            if image_np.shape[2] == 1:
                PIL.Image.fromarray(image_np[:, :, 0], 'L').save(image_path)
            else:
                # PIL.Image.fromarray(image_np, 'RGB').save(image_path) #dont have 3 RGB channels for the T2sh data
                PIL.Image.fromarray(np.abs(image_np[:, :, 0] + 1j*image_np[:, :, 1]), 'L').save(image_path)
        np.save(os.path.join(image_dir, 'generated_samples.npy'), images_np_without_normalize)
    # Done.
    torch.distributed.barrier()
    dist.print0('Done.')

#----------------------------------------------------------------------------

if __name__ == "__main__":
    main()

#----------------------------------------------------------------------------
