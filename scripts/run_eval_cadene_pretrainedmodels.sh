#!/usr/bin/env bash

python pretrained-models.pytorch/examples/imagenet_eval.py -e -a vgg19 -b 20 --data /data/datasets/imagenet_jpeg/ilsvrc2012/torchvision 2>&1 | tee logs/eval_vgg19.log

python pretrained-models.pytorch/examples/imagenet_eval.py -e -a resnet50 -b 20 --data /data/datasets/imagenet_jpeg/ilsvrc2012/torchvision 2>&1 | tee logs/eval_resnet50.log

python pretrained-models.pytorch/examples/imagenet_eval.py -e -a inceptionv3 -b 20 --data /data/datasets/imagenet_jpeg/ilsvrc2012/torchvision 2>&1 | tee logs/eval_inceptionv3.log

python pretrained-models.pytorch/examples/imagenet_eval.py -e -a inceptionresnetv2 -b 20 --data /data/datasets/imagenet_jpeg/ilsvrc2012/torchvision 2>&1 | tee logs/eval_inceptionresnetv2.log

python pretrained-models.pytorch/examples/imagenet_eval.py -e -a nasnetalarge -b 20 --data /data/datasets/imagenet_jpeg/ilsvrc2012/torchvision 2>&1 | tee logs/eval_nasnetalarge.log

