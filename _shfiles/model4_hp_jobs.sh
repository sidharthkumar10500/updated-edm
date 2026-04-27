# tick="5272"
# python hp_optimizer.py --seeds 0 --ksp_dir /csiNAS/sidharth/FastMRI_val/undersampled_R_3 --steps 300 --likelihood_step_size 1.0 --GPU_idx 0 --outdir /csiNAS/sidharth/FastMRI_val/model4_outputs/hp_optimize/R=3 --network /csiNAS/sidharth/edm/trained_models/model4/lr=1e-5/network-snapshot-00"${tick}".pkl&
# python hp_optimizer.py --seeds 0 --ksp_dir /csiNAS/sidharth/FastMRI_val/undersampled_R_4 --steps 300 --likelihood_step_size 1.0 --GPU_idx 1 --outdir /csiNAS/sidharth/FastMRI_val/model4_outputs/hp_optimize/R=4 --network /csiNAS/sidharth/edm/trained_models/model4/lr=1e-5/network-snapshot-00"${tick}".pkl&
# python hp_optimizer.py --seeds 0 --ksp_dir /csiNAS/sidharth/FastMRI_val/undersampled_R_5 --steps 300 --likelihood_step_size 1.0 --GPU_idx 2 --outdir /csiNAS/sidharth/FastMRI_val/model4_outputs/hp_optimize/R=5 --network /csiNAS/sidharth/edm/trained_models/model4/lr=5e-5/network-snapshot-00"${tick}".pkl&
# python hp_optimizer.py --seeds 0 --ksp_dir /csiNAS/sidharth/FastMRI_val/undersampled_R_6 --steps 300 --likelihood_step_size 1.0 --GPU_idx 3 --outdir /csiNAS/sidharth/FastMRI_val/model4_outputs/hp_optimize/R=6 --network /csiNAS/sidharth/edm/trained_models/model4/lr=1e-5/network-snapshot-00"${tick}".pkl&



tick="5272"
python hp_optimizer.py --seeds 0 --ksp_dir /csiNAS/sidharth/FastMRI_val/undersampled_HP_R_7 --steps 300 --likelihood_step_size 1.0 --GPU_idx 0 --outdir /csiNAS/sidharth/FastMRI_val/model4_outputs/hp_optimize/R=7 --network /csiNAS/sidharth/edm/trained_models/model4/lr=1e-5/network-snapshot-00"${tick}".pkl&
python hp_optimizer.py --seeds 0 --ksp_dir /csiNAS/sidharth/FastMRI_val/undersampled_HP_R_8 --steps 300 --likelihood_step_size 1.0 --GPU_idx 1 --outdir /csiNAS/sidharth/FastMRI_val/model4_outputs/hp_optimize/R=8 --network /csiNAS/sidharth/edm/trained_models/model4/lr=1e-5/network-snapshot-00"${tick}".pkl&
