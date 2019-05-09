
docker image: refer run_docker.sh

git clone https://github.com/vuiseng9/nervana-distiller
cd nervana-distiller
pip install -r python-dep.txt
source env.sh
source scripts/run_eval_cadene_pretrainedmodels.sh



# Post-training Quantization

# Calibration
python ./distiller/examples/classifier_compression/compress_classifier.py \
    -a=resnet18 -p=10 -j=8 /data/datasets/imagenet_jpeg/ilsvrc2012/torchvision \
    --pretrained --qe-calibration 0.05 --gpu 0

# Generated Stats:
# ----------------
logs/2019.05.02-165934/quantization_stats

python3 ./distiller/examples/classifier_compression/compress_classifier.py -a resnet18 --pretrained --quantize-eval --evaluate -j 8 --gpu 0 /data/datasets/imagenet_jpeg/ilsvrc2012/torchvision --qe-stats-file logs/2019.05.02-165934/quantization_stats.yaml
