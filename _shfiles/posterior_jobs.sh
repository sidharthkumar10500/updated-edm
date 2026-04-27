# for i in {1..10..1}
# for i in 0.1 0.5 20 50 100 1000
# for i in 0.6 0.7 0.8 0.9 1.1 1.2 1.3 1.4 1.5
# for i in 1.6 1.7 1.8 1.9 2.0 2.5 3.0
# yamma_arr=(0.6, 0.7, 0.8, 0.9, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2.0, 2.5, 3.0, 0.1, 0.5, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0)
# yamma_arr=(2.0 , 2.1, 2.2, 2.3, 2.4, 2.5, 2.6, 2.7, 2.8, 2.9, 3.0 , 3.1, 3.2, 3.3, 3.4, 3.5, 3.6, 3.7, 3.8, 3.9, 4.0)
# for i in "${yamma_arr[@]}"
# do 
#   echo "${i:0:3}"
#   python fastmri_posterior.py --seeds 0 --ksp_file experimental_MPRAGE_actual_3.8.pt --steps 300 --likelihood_step_size ${i:0:3}
# done
# for max_iter in {100..1000..100}
# do
#   python fastmri_posterior.py --seeds 0 --ksp_file experimental_MPRAGE_actual_3.8.pt --steps $max_iter --likelihood_step_size 3
# done

# python fastmri_posterior.py --seeds 0 --ksp_file experimental_DWI_DIR_8_R_4.pt --steps 1000 --likelihood_step_size 1
 
# python fastmri_posterior.py --seeds 0-4 --ksp_file experimental_MPRAGE_actual_3.8.pt --steps 1000 --likelihood_step_size 3

# python fastmri_posterior.py --seeds 0-4 --ksp_file experimental_FLAIR_actual_4.68.pt --steps 1000 --likelihood_step_size 4 &
# python fastmri_posterior.py --seeds 0-4 --ksp_file experimental_FLAIR_actual_2.89.pt --steps 1000 --likelihood_step_size 4 &
# python fastmri_posterior.py --seeds 0-4 --ksp_file experimental_MPRAGE_actual_2.96.pt --steps 1000 --likelihood_step_size 2.5 &


python fastmri_posterior.py --seeds 0-4 --ksp_file experimental_FLAIR_actual_2.60.pt --steps 1000 --likelihood_step_size 1.0 --outdir /csiNAS2/slow/sidharth/out_fastmri/R_further=2
python fastmri_posterior.py --seeds 0-4 --ksp_file experimental_FLAIR_actual_3.21.pt --steps 1000 --likelihood_step_size 2.5 
python fastmri_posterior.py --seeds 0-4 --ksp_file experimental_FLAIR_actual_3.52.pt --steps 1000 --likelihood_step_size 3.0 

# python fastmri_posterior.py --seeds 0-4 --ksp_file experimental_MPRAGE_actual_4.04.pt --steps 300 --likelihood_step_size 2.0 
# python fastmri_posterior.py --seeds 0-4 --ksp_file experimental_MPRAGE_actual_4.48.pt --steps 300 --likelihood_step_size 2.0 
# python fastmri_posterior.py --seeds 0-4 --ksp_file experimental_MPRAGE_actual_4.77.pt --steps 300 --likelihood_step_size 2.0 
# python fastmri_posterior.py --seeds 0-4 --ksp_file experimental_MPRAGE_actual_4.98.pt --steps 300 --likelihood_step_size 2.5 