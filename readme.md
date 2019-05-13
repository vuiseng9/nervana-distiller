# Using nervana-distiller
*May'19*

This repo provides an operating enviroment for nervana-systems/distiller. Why? standardization on workflow. We rely on pre-built pytorch docker image and the rest of the operation will be carried out in docker runtime.

```
git clone https://github.com/vuiseng9/nervana-distiller
cd nervana-distiller

# Launch pytorch docker runtime
./run_docker.sh

# =========================================================
# We operate in docker runtime from this point onwards, 
apt-get update && apt-get install -y vim curl wget

ln -sv /hosthome/nervana-distiller .
cd nervana-distiller
pip install -r python-dep.txt

# Setup environment to run distiller - this script pulls the required repos and sets up environment variables
source env.sh

# Scoring pretrained models - we can use this step to validate if environment is working correctly
source scripts/run_eval_cadene_pretrainedmodels.sh

# At this point, we may save the runtime as a docker image
sudo docker commit <runtime id> nervana-distiller
```
*vuiseng9 personal notes: Steps above reproducible in pytorch-tf-gpu of ml-docker*

#### Launching Jupyter lab
```
cd /workspace
jupyter lab --ip 0.0.0.0 --allow-root
```

### Evaluation on pretrained models
```
source scripts/run_eval_cadene_pretrainedmodels.sh
```

### Post-training Quantization

### Calibration
python ./distiller/examples/classifier_compression/compress_classifier.py \
    -a=resnet18 -p=10 -j=8 /data/datasets/imagenet_jpeg/ilsvrc2012/torchvision \
    --pretrained --qe-calibration 0.05 --gpu 0

# Generated Stats:
# ----------------
logs/2019.05.02-165934/quantization_stats

python3 ./distiller/examples/classifier_compression/compress_classifier.py -a resnet18 --pretrained --quantize-eval --evaluate -j 8 --gpu 0 /data/datasets/imagenet_jpeg/ilsvrc2012/torchvision --qe-stats-file logs/<timestamp>/quantization_stats.yaml
