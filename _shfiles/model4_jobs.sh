# # This script is for running jobs to find the optimal triaining point for model 4
# for tick in 5071 5272 5474 5675 5877 #5675 6079 6482 6885
# do 
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/FastMRI_val/undersampled_R_3 --steps 300 --likelihood_step_size 1.0 --GPU_idx 0 --outdir /csiNAS/sidharth/FastMRI_val/model4_outputs/lr=1e-4/tick_"${tick}"/R=3 --network /csiNAS/sidharth/edm/trained_models/model4/lr=1e-4/network-snapshot-00"${tick}".pkl&
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/FastMRI_val/undersampled_R_4 --steps 300 --likelihood_step_size 1.0 --GPU_idx 1 --outdir /csiNAS/sidharth/FastMRI_val/model4_outputs/lr=1e-4/tick_"${tick}"/R=4 --network /csiNAS/sidharth/edm/trained_models/model4/lr=1e-4/network-snapshot-00"${tick}".pkl&
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/FastMRI_val/undersampled_R_5 --steps 300 --likelihood_step_size 1.0 --GPU_idx 2 --outdir /csiNAS/sidharth/FastMRI_val/model4_outputs/lr=1e-4/tick_"${tick}"/R=5 --network /csiNAS/sidharth/edm/trained_models/model4/lr=1e-4/network-snapshot-00"${tick}".pkl&
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/FastMRI_val/undersampled_R_6 --steps 300 --likelihood_step_size 1.0 --GPU_idx 3 --outdir /csiNAS/sidharth/FastMRI_val/model4_outputs/lr=1e-4/tick_"${tick}"/R=6 --network /csiNAS/sidharth/edm/trained_models/model4/lr=1e-4/network-snapshot-00"${tick}".pkl&
# wait
# done

# for tick in 5071 5272 5474 5675 5877 #5675 6079 6482 6885
# do 
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/FastMRI_val/undersampled_R_3 --steps 300 --likelihood_step_size 1.0 --GPU_idx 0 --outdir /csiNAS/sidharth/FastMRI_val/model4_outputs/lr=5e-4/tick_"${tick}"/R=3 --network /csiNAS/sidharth/edm/trained_models/model4/lr=5e-4/network-snapshot-00"${tick}".pkl&
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/FastMRI_val/undersampled_R_4 --steps 300 --likelihood_step_size 1.0 --GPU_idx 1 --outdir /csiNAS/sidharth/FastMRI_val/model4_outputs/lr=5e-4/tick_"${tick}"/R=4 --network /csiNAS/sidharth/edm/trained_models/model4/lr=5e-4/network-snapshot-00"${tick}".pkl&
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/FastMRI_val/undersampled_R_5 --steps 300 --likelihood_step_size 1.0 --GPU_idx 2 --outdir /csiNAS/sidharth/FastMRI_val/model4_outputs/lr=5e-4/tick_"${tick}"/R=5 --network /csiNAS/sidharth/edm/trained_models/model4/lr=5e-4/network-snapshot-00"${tick}".pkl&
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/FastMRI_val/undersampled_R_6 --steps 300 --likelihood_step_size 1.0 --GPU_idx 3 --outdir /csiNAS/sidharth/FastMRI_val/model4_outputs/lr=5e-4/tick_"${tick}"/R=6 --network /csiNAS/sidharth/edm/trained_models/model4/lr=5e-4/network-snapshot-00"${tick}".pkl&
# wait
# done

# for tick in 5071 5272 5474 5675 5877 # 5675 6079 6482 6885
# do 
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/FastMRI_val/undersampled_R_3 --steps 300 --likelihood_step_size 1.0 --GPU_idx 0 --outdir /csiNAS/sidharth/FastMRI_val/model4_outputs/lr=5e-5/tick_"${tick}"/R=3 --network /csiNAS/sidharth/edm/trained_models/model4/lr=5e-5/network-snapshot-00"${tick}".pkl&
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/FastMRI_val/undersampled_R_4 --steps 300 --likelihood_step_size 1.0 --GPU_idx 1 --outdir /csiNAS/sidharth/FastMRI_val/model4_outputs/lr=5e-5/tick_"${tick}"/R=4 --network /csiNAS/sidharth/edm/trained_models/model4/lr=5e-5/network-snapshot-00"${tick}".pkl&
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/FastMRI_val/undersampled_R_5 --steps 300 --likelihood_step_size 1.0 --GPU_idx 2 --outdir /csiNAS/sidharth/FastMRI_val/model4_outputs/lr=5e-5/tick_"${tick}"/R=5 --network /csiNAS/sidharth/edm/trained_models/model4/lr=5e-5/network-snapshot-00"${tick}".pkl&
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/FastMRI_val/undersampled_R_6 --steps 300 --likelihood_step_size 1.0 --GPU_idx 3 --outdir /csiNAS/sidharth/FastMRI_val/model4_outputs/lr=5e-5/tick_"${tick}"/R=6 --network /csiNAS/sidharth/edm/trained_models/model4/lr=5e-5/network-snapshot-00"${tick}".pkl&
# wait
# done

# for tick in 5071 5272 5474 5675 5877 #5675 6079 6482 6885
# do 
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/FastMRI_val/undersampled_R_3 --steps 300 --likelihood_step_size 1.0 --GPU_idx 0 --outdir /csiNAS/sidharth/FastMRI_val/model4_outputs/lr=1e-5/tick_"${tick}"/R=3 --network /csiNAS/sidharth/edm/trained_models/model4/lr=1e-5/network-snapshot-00"${tick}".pkl&
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/FastMRI_val/undersampled_R_4 --steps 300 --likelihood_step_size 1.0 --GPU_idx 1 --outdir /csiNAS/sidharth/FastMRI_val/model4_outputs/lr=1e-5/tick_"${tick}"/R=4 --network /csiNAS/sidharth/edm/trained_models/model4/lr=1e-5/network-snapshot-00"${tick}".pkl&
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/FastMRI_val/undersampled_R_5 --steps 300 --likelihood_step_size 1.0 --GPU_idx 2 --outdir /csiNAS/sidharth/FastMRI_val/model4_outputs/lr=1e-5/tick_"${tick}"/R=5 --network /csiNAS/sidharth/edm/trained_models/model4/lr=1e-5/network-snapshot-00"${tick}".pkl&
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/FastMRI_val/undersampled_R_6 --steps 300 --likelihood_step_size 1.0 --GPU_idx 3 --outdir /csiNAS/sidharth/FastMRI_val/model4_outputs/lr=1e-5/tick_"${tick}"/R=6 --network /csiNAS/sidharth/edm/trained_models/model4/lr=1e-5/network-snapshot-00"${tick}".pkl&
# wait
# done

# for lr in 1e-5 5e-5 1e-4 5e-4
# do
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/FastMRI_val/undersampled_R_7 --steps 300 --likelihood_step_size 1.0 --GPU_idx 0 --outdir /csiNAS/sidharth/FastMRI_val/model4_outputs/lr="${lr}"/tick_5272/R=7 --network /csiNAS/sidharth/edm/trained_models/model4/lr="${lr}"/network-snapshot-005272.pkl&
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/FastMRI_val/undersampled_R_7 --steps 300 --likelihood_step_size 1.0 --GPU_idx 1 --outdir /csiNAS/sidharth/FastMRI_val/model4_outputs/lr="${lr}"/tick_5474/R=7 --network /csiNAS/sidharth/edm/trained_models/model4/lr="${lr}"/network-snapshot-005474.pkl&
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/FastMRI_val/undersampled_R_7 --steps 300 --likelihood_step_size 1.0 --GPU_idx 2 --outdir /csiNAS/sidharth/FastMRI_val/model4_outputs/lr="${lr}"/tick_5675/R=7 --network /csiNAS/sidharth/edm/trained_models/model4/lr="${lr}"/network-snapshot-005675.pkl&
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/FastMRI_val/undersampled_R_7 --steps 300 --likelihood_step_size 1.0 --GPU_idx 3 --outdir /csiNAS/sidharth/FastMRI_val/model4_outputs/lr="${lr}"/tick_5877/R=7 --network /csiNAS/sidharth/edm/trained_models/model4/lr="${lr}"/network-snapshot-005877.pkl&
# wait
# done


# for lr in 1e-5 5e-5 1e-4 5e-4
# do
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/FastMRI_val/undersampled_R_8 --steps 300 --likelihood_step_size 1.0 --GPU_idx 0 --outdir /csiNAS/sidharth/FastMRI_val/model4_outputs/lr="${lr}"/tick_5272/R=8 --network /csiNAS/sidharth/edm/trained_models/model4/lr="${lr}"/network-snapshot-005272.pkl &
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/FastMRI_val/undersampled_R_8 --steps 300 --likelihood_step_size 1.0 --GPU_idx 1 --outdir /csiNAS/sidharth/FastMRI_val/model4_outputs/lr="${lr}"/tick_5474/R=8 --network /csiNAS/sidharth/edm/trained_models/model4/lr="${lr}"/network-snapshot-005474.pkl &
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/FastMRI_val/undersampled_R_8 --steps 300 --likelihood_step_size 1.0 --GPU_idx 2 --outdir /csiNAS/sidharth/FastMRI_val/model4_outputs/lr="${lr}"/tick_5675/R=8 --network /csiNAS/sidharth/edm/trained_models/model4/lr="${lr}"/network-snapshot-005675.pkl &
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/FastMRI_val/undersampled_R_8 --steps 300 --likelihood_step_size 1.0 --GPU_idx 3 --outdir /csiNAS/sidharth/FastMRI_val/model4_outputs/lr="${lr}"/tick_5877/R=8 --network /csiNAS/sidharth/edm/trained_models/model4/lr="${lr}"/network-snapshot-005877.pkl &
# wait
# done

for lr in 1e-5 
do
python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/FastMRI_val/undersampled_R_8 --steps 300 --likelihood_step_size 1.0 --GPU_idx 0 --outdir /csiNAS/sidharth/FastMRI_val/model4_outputs/lr="${lr}"/tick_5071/R=8 --network /csiNAS/sidharth/edm/trained_models/model4/lr="${lr}"/network-snapshot-005071.pkl &
python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/FastMRI_val/undersampled_R_7 --steps 300 --likelihood_step_size 1.0 --GPU_idx 1 --outdir /csiNAS/sidharth/FastMRI_val/model4_outputs/lr="${lr}"/tick_5071/R=7 --network /csiNAS/sidharth/edm/trained_models/model4/lr="${lr}"/network-snapshot-005071.pkl &
done