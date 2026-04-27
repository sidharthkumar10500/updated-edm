# Generate 64 images and save them as out/*.png
python generate.py --outdir=prior_samples/model1 --seeds=0-63 --batch=8 --class=1 --steps=300\
    --network=/csiNAS/sidharth/edm/trained_models/model1/network-snapshot-005040.pkl
