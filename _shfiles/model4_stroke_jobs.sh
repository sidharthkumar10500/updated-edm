# # This script is for running jobs to find the optimal triaining point for stroke models
# for tick in 7056 7257 7459 7660 7862 
# do 
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/Stroke_5_subjects_data_val/FLAIR_clean --steps 300 --likelihood_step_size 1.0 --GPU_idx 0 --outdir /csiNAS/sidharth/Stroke_5_subjects_data_val/model4_outputs/FLAIR/lr=1e-5/tick_"${tick}" --network /csiNAS/sidharth/edm/trained_models/model_FLAIR/lr=1e-5/network-snapshot-00"${tick}".pkl --class_idx 8&
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/Stroke_5_subjects_data_val/SWI_clean --steps 300 --likelihood_step_size 1.0 --GPU_idx 1 --outdir /csiNAS/sidharth/Stroke_5_subjects_data_val/model4_outputs/SWI/lr=1e-5/tick_"${tick}" --network /csiNAS/sidharth/edm/trained_models/model_SWI/lr=1e-5/network-snapshot-00"${tick}".pkl --class_idx 5&
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/Stroke_5_subjects_data_val/DWI_clean --steps 300 --likelihood_step_size 1.0 --GPU_idx 2 --outdir /csiNAS/sidharth/Stroke_5_subjects_data_val/model4_outputs/DWI/lr=1e-5/tick_"${tick}" --network /csiNAS/sidharth/edm/trained_models/model_DWI/lr=1e-5/network-snapshot-00"${tick}".pkl --class_idx 6&
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/Stroke_5_subjects_data_val/MPRAGE_clean --steps 300 --likelihood_step_size 1.0 --GPU_idx 3 --outdir /csiNAS/sidharth/Stroke_5_subjects_data_val/model4_outputs/MPRAGE/lr=1e-5/tick_"${tick}" --network /csiNAS/sidharth/edm/trained_models/model_MPRAGE/lr=1e-5/network-snapshot-00"${tick}".pkl --class_idx 7&
# wait
# done


# # This script is for running jobs to find the optimal triaining point for stroke models
# for tick in 7056 7257 7459 7660 7862 
# do 
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/Stroke_5_subjects_data_val/DWI_B0_clean --steps 300 --likelihood_step_size 1.0 --GPU_idx 0 --outdir /csiNAS/sidharth/Stroke_5_subjects_data_val/model4_outputs/DWI_B0/lr=1e-5/tick_"${tick}" --network /csiNAS/sidharth/edm/trained_models/model_DWI_B0/lr=1e-5/network-snapshot-00"${tick}".pkl --class_idx 6&
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/Stroke_5_subjects_data_val/DWI_B1200_clean --steps 300 --likelihood_step_size 1.0 --GPU_idx 1 --outdir /csiNAS/sidharth/Stroke_5_subjects_data_val/model4_outputs/DWI_B1200/lr=1e-5/tick_"${tick}" --network /csiNAS/sidharth/edm/trained_models/model_DWI_B1200/lr=1e-5/network-snapshot-00"${tick}".pkl --class_idx 6&
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/Stroke_5_subjects_data_val/DWI_B0_clean --steps 300 --likelihood_step_size 1.0 --GPU_idx 2 --outdir /csiNAS/sidharth/Stroke_5_subjects_data_val/model4_outputs/DWI_B0/lr=5e-5/tick_"${tick}" --network /csiNAS/sidharth/edm/trained_models/model_DWI_B0/lr=5e-5/network-snapshot-00"${tick}".pkl --class_idx 6&
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/Stroke_5_subjects_data_val/DWI_B1200_clean --steps 300 --likelihood_step_size 1.0 --GPU_idx 3 --outdir /csiNAS/sidharth/Stroke_5_subjects_data_val/model4_outputs/DWI_B1200/lr=5e-5/tick_"${tick}" --network /csiNAS/sidharth/edm/trained_models/model_DWI_B1200/lr=5e-5/network-snapshot-00"${tick}".pkl --class_idx 6&
# wait
# done


# for tick in 7257 7459 7660 7862 
# do 
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/Stroke_5_subjects_data_val/DWI_B0_clean --steps 300 --likelihood_step_size 1.0 --GPU_idx 0 --outdir /csiNAS/sidharth/Stroke_5_subjects_data_val/model4_outputs/DWI_B0/lr=1e-4/tick_"${tick}" --network /csiNAS/sidharth/edm/trained_models/model_DWI_B0/lr=1e-4/network-snapshot-00"${tick}".pkl --class_idx 6&
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/Stroke_5_subjects_data_val/DWI_B1200_clean --steps 300 --likelihood_step_size 1.0 --GPU_idx 1 --outdir /csiNAS/sidharth/Stroke_5_subjects_data_val/model4_outputs/DWI_B1200/lr=1e-4/tick_"${tick}" --network /csiNAS/sidharth/edm/trained_models/model_DWI_B1200/lr=1e-4/network-snapshot-00"${tick}".pkl --class_idx 6&
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/Stroke_5_subjects_data_val/DWI_B0_clean --steps 300 --likelihood_step_size 1.0 --GPU_idx 2 --outdir /csiNAS/sidharth/Stroke_5_subjects_data_val/model4_outputs/DWI_B0/lr=5e-4/tick_"${tick}" --network /csiNAS/sidharth/edm/trained_models/model_DWI_B0/lr=5e-4/network-snapshot-00"${tick}".pkl --class_idx 6&
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/Stroke_5_subjects_data_val/DWI_B1200_clean --steps 300 --likelihood_step_size 1.0 --GPU_idx 3 --outdir /csiNAS/sidharth/Stroke_5_subjects_data_val/model4_outputs/DWI_B1200/lr=5e-4/tick_"${tick}" --network /csiNAS/sidharth/edm/trained_models/model_DWI_B1200/lr=5e-4/network-snapshot-00"${tick}".pkl --class_idx 6&
# wait
# done


# for tick in 7257 
# do 
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/Stroke_5_subjects_data_test/DWI_B0_clean --steps 300 --likelihood_step_size 0.8 --GPU_idx 0 --outdir /csiNAS/sidharth/Stroke_5_subjects_data_test/model4_outputs/DWI_B0/lr=1e-5/tick_"${tick}" --network /csiNAS/sidharth/edm/trained_models/model_DWI_B0/lr=1e-5/network-snapshot-00"${tick}".pkl --class_idx 6&
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/Stroke_5_subjects_data_test/DWI_B1200_clean --steps 300 --likelihood_step_size 1.4 --GPU_idx 0 --outdir /csiNAS/sidharth/Stroke_5_subjects_data_test/model4_outputs/DWI_B1200/lr=1e-5/tick_"${tick}" --network /csiNAS/sidharth/edm/trained_models/model_DWI_B1200/lr=1e-5/network-snapshot-00"${tick}".pkl --class_idx 6&
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/Stroke_5_subjects_data_test/FLAIR_clean --steps 300 --likelihood_step_size 1.9 --GPU_idx 2 --outdir /csiNAS/sidharth/Stroke_5_subjects_data_test/model4_outputs/FLAIR/lr=1e-5/tick_"${tick}" --network /csiNAS/sidharth/edm/trained_models/model_FLAIR/lr=1e-5/network-snapshot-00"${tick}".pkl --class_idx 8&
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/Stroke_5_subjects_data_test/SWI_clean --steps 300 --likelihood_step_size 2.1 --GPU_idx 1 --outdir /csiNAS/sidharth/Stroke_5_subjects_data_test/model4_outputs/SWI/lr=1e-5/tick_"${tick}" --network /csiNAS/sidharth/edm/trained_models/model_SWI/lr=1e-5/network-snapshot-00"${tick}".pkl --class_idx 5&
# python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/Stroke_5_subjects_data_test/MPRAGE_clean --steps 300 --likelihood_step_size 2.0 --GPU_idx 3 --outdir /csiNAS/sidharth/Stroke_5_subjects_data_test/model4_outputs/MPRAGE/lr=1e-5/tick_"${tick}" --network /csiNAS/sidharth/edm/trained_models/model_MPRAGE/lr=1e-5/network-snapshot-00"${tick}".pkl --class_idx 7&
# wait
# done


python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/Stroke_5_subjects_data_test/Test_2/SWI --steps 300 --likelihood_step_size 2.1 --GPU_idx 0 --outdir /csiNAS/sidharth/Stroke_5_subjects_data_test/Test_2/SWI/lr=1e-5/tick_7257 --network /csiNAS/sidharth/edm/trained_models/model_SWI/lr=1e-5/network-snapshot-007257.pkl --class_idx 5&
python dps_runner_slices.py --seeds 0 --ksp_dir /csiNAS/sidharth/Stroke_5_subjects_data_test/Test_2/SWI --steps 300 --likelihood_step_size 1.0 --GPU_idx 1 --outdir /csiNAS/sidharth/Stroke_5_subjects_data_test/Test_2/SWI/lr=1e-5/tick_7056 --network /csiNAS/sidharth/edm/trained_models/model_SWI/lr=1e-5/network-snapshot-007056.pkl --class_idx 5&
