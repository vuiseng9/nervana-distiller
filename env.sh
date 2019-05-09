# source bash utility
source scripts/utils.sh

# required env variables 
varlist="
    WORKDIR
    CUDA_VISIBLE_DEVICES"

# set env variables
export WORKDIR=`pwd`
export CUDA_VISIBLE_DEVICES=0

# create required folders
dirlist="inputs outputs logs ipynb"
makedirs $dirlist

# clone required repos
clonelist="
https://github.com/nervanasystems/distiller.git
https://github.com/Cadene/pretrained-models.pytorch"

clone_repos $clonelist

export DISTILLER_ROOT=${WORKDIR}/distiller
export PYTHONPATH=${DISTILLER_ROOT}:${PYTHONPATH}

# log required variables
logvars $varlist
