#!/usr/bin/env bash

container=pytorch/pytorch:1.0.1-cuda10.0-cudnn7-runtime

DOCKER_PROXY_RUN_ARGS="\
            --env HTTPS_PROXY=$HTTPS_PROXY \
            --env https_proxy=$https_proxy \
            --env HTTP_PROXY=$HTTP_PROXY \
            --env http_proxy=$http_proxy \
            --env NO_PROXY=$NO_PROXY \
            --env no_proxy=$no_proxy \
            --dns 10.248.2.1"

sudo xhost +local:`sudo docker inspect --format='{{ .Config.Hostname }}' ${container}`

# if you'd like to have same user as host user add the following to docker run
#   -u $(id -u):$(id -g) \

sudo nvidia-docker run $DOCKER_PROXY_RUN_ARGS -it \
    --init \
    --privileged \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v ${HOME}:/hosthome \
    --shm-size 8G \
	-v /data:/data \
	-p 8268:8888 \
	-p 6266:6006 \
	${container} bash
