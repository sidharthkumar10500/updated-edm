# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/Fastmri_whitened/subject_13_DWI_DPS_Data/R_further=4 --steps 300 --likelihood_step_size 2.0 --GPU_idx 0 --outdir /csiNAS2/slow/sidharth/out_fastmri/subject_13_DWI_DPS_Data/R_further=4 &
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/Fastmri_whitened/subject_14_DWI_DPS_Data/R_further=4 --steps 300 --likelihood_step_size 2.0 --GPU_idx 0 --outdir /csiNAS2/slow/sidharth/out_fastmri/subject_14_DWI_DPS_Data/R_further=4 &
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/Fastmri_whitened/subject_25_DWI_DPS_Data/R_further=4 --steps 300 --likelihood_step_size 2.0 --GPU_idx 1 --outdir /csiNAS2/slow/sidharth/out_fastmri/subject_25_DWI_DPS_Data/R_further=4 &
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/Fastmri_whitened/subject_26_DWI_DPS_Data/R_further=4 --steps 300 --likelihood_step_size 2.0 --GPU_idx 2 --outdir /csiNAS2/slow/sidharth/out_fastmri/subject_26_DWI_DPS_Data/R_further=4 &
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/Fastmri_whitened/subject_27_DWI_DPS_Data/R_further=4 --steps 300 --likelihood_step_size 2.0 --GPU_idx 2 --outdir /csiNAS2/slow/sidharth/out_fastmri/subject_27_DWI_DPS_Data/R_further=4 &
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/Fastmri_whitened/subject_28_DWI_DPS_Data/R_further=4 --steps 300 --likelihood_step_size 2.0 --GPU_idx 3 --outdir /csiNAS2/slow/sidharth/out_fastmri/subject_28_DWI_DPS_Data/R_further=4 &
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/Fastmri_whitened/subject_29_DWI_DPS_Data/R_further=4 --steps 300 --likelihood_step_size 2.0 --GPU_idx 3 --outdir /csiNAS2/slow/sidharth/out_fastmri/subject_29_DWI_DPS_Data/R_further=4 &
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/Fastmri_whitened/subject_30_DWI_DPS_Data/R_further=4 --steps 300 --likelihood_step_size 2.0 --GPU_idx 3 --outdir /csiNAS2/slow/sidharth/out_fastmri/subject_30_DWI_DPS_Data/R_further=4 &
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/Fastmri_whitened/subject_4_DWI_DPS_Data/R_further=4 --steps 300 --likelihood_step_size 2.0 --GPU_idx 3 --outdir /csiNAS2/slow/sidharth/out_fastmri/subject_4_DWI_DPS_Data/R_further=4 &


# for subject in {31..110} 
# do 
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/Fastmri_whitened/subject_"${subject}"_DWI_DPS_Data/direction_B0/R_further=4 --steps 300 --likelihood_step_size 0.8 --GPU_idx 3 --outdir /csiNAS2/slow/sidharth/out_fastmri/subject_"${subject}"_DWI_DPS_Data/direction_B0/R_further=4 --network /csiNAS/sidharth/edm/trained_models/model_DWI_B0/lr=1e-5/network-snapshot-007257.pkl --class_idx 6
# done


for subject in {41..50} 
do 
python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/Fastmri_whitened/subject_"${subject}"_DWI_DPS_Data/direction_B1200/R_further=4 --steps 300 --likelihood_step_size 1.4 --GPU_idx 1 --outdir /csiNAS2/slow/sidharth/out_fastmri/subject_"${subject}"_DWI_DPS_Data/direction_B1200/R_further=4 --network /csiNAS/sidharth/edm/trained_models/model_DWI_B1200/lr=1e-5/network-snapshot-007257.pkl --class_idx 6&
subject=$((subject+20))
python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/Fastmri_whitened/subject_"${subject}"_DWI_DPS_Data/direction_B1200/R_further=4 --steps 300 --likelihood_step_size 1.4 --GPU_idx 2 --outdir /csiNAS2/slow/sidharth/out_fastmri/subject_"${subject}"_DWI_DPS_Data/direction_B1200/R_further=4 --network /csiNAS/sidharth/edm/trained_models/model_DWI_B1200/lr=1e-5/network-snapshot-007257.pkl --class_idx 6&
subject=$((subject+20))
python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/Fastmri_whitened/subject_"${subject}"_DWI_DPS_Data/direction_B1200/R_further=4 --steps 300 --likelihood_step_size 1.4 --GPU_idx 0 --outdir /csiNAS2/slow/sidharth/out_fastmri/subject_"${subject}"_DWI_DPS_Data/direction_B1200/R_further=4 --network /csiNAS/sidharth/edm/trained_models/model_DWI_B1200/lr=1e-5/network-snapshot-007257.pkl --class_idx 6&
wait
done