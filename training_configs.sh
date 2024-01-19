# torchrun --standalone --nproc_per_node=3 train.py --outdir=/data/edm_outputs --data=/data/edm_training_data/fastmri_all_preprocessed --cond=1 --arch=ddpmpp --duration=10 --batch=15 --cbase=128 --cres=1,1,2,2,2,2,2 --lr=1e-4 --ema=0.1 --dropout=0.0 --desc=container_test --tick=1 --dump=100 --seed=2023 --precond edm

# VE
# CUDA_VISIBLE_DEVICES=2,3 torchrun --standalone --nproc_per_node=2 train.py --outdir=training-runs --data=datasets/edm_t2sh_data.zip --cond=0 --arch=ncsnpp --batch=16 --duration=10 --cbase=128 --cres=1,1,2,2,2,2,2 --snap=10 --dump=100 --lr=1e-4 --ema=0.1 --dropout=0.0 --augment=0.15 --tick=1 --seed=2023 --precond edm --desc=container_test
# CUDA_VISIBLE_DEVICES=2,3 torchrun --standalone --nproc_per_node=2 train.py --outdir=training-runs --data=edm_t2sh_data --cond=0 --arch=ddpmpp --duration=10 --batch=32 --cbase=128 --cres=1,1,2,2,2,2,2 --lr=1e-4 --ema=0.1 --dropout=0.0 --desc=container_test --tick=1 --snap=100 --dump=100 --seed=2023 --precond edm


# CUDA_VISIBLE_DEVICES=1,2,3 torchrun --standalone --nproc_per_node=2 train.py --outdir=training-runs --data=edm_t2sh_data_2channel --cond=0 --arch=ddpmpp --duration=10 --batch=32 --cbase=128 --cres=1,1,2,2,2,2,2 --lr=1e-4 --ema=0.1 --dropout=0.0 --desc=container_test --tick=1 --snap=100 --dump=100 --seed=2023 --precond edm


# CUDA_VISIBLE_DEVICES=3 torchrun --standalone --nproc_per_node=1 train.py --outdir=training-runs --data=edm_t2sh_data_6channel --cond=0 --arch=ddpmpp --duration=10 --batch=16 --cbase=128 --cres=1,1,2,2,2,2,2 --lr=1e-4 --ema=0.1 --dropout=0.0 --desc=container_test --tick=1 --snap=200 --dump=200 --seed=2023 --precond edm

CUDA_VISIBLE_DEVICES=2 torchrun --standalone --nproc_per_node=1 train.py --outdir=training-runs-fastmri --data=AXT2 --cond=0 --arch=ddpmpp --duration=10 --batch=8 --cbase=128 --cres=1,1,2,2,2,2,2 --lr=1e-4 --ema=0.1 --dropout=0.0 --desc=container_test --tick=1 --snap=200 --dump=200 --seed=2023 --precond edm