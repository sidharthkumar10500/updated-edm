# !/bin/bash
# bash script to run multiple simulations one after another to automate stuff
# need to look at how to do parrallel runs on multiple gpus
for weight3 in 0 0.5 5 50
do
    for weight2 in  0 0.5 5 50 
    do
        python generate_diff_6channel.py --weight2 $weight2 --weight3 $weight3
    done
done
echo "All done"