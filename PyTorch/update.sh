#!/usr/bin/env bash

################
# First Docker #
################

# Create Dockerfiles from template
template="Dockerfile_base.template"
shell_format='${BASE},${PYTORCH_VER},${PYTORCH_CUDA_VER},${CUDNN_VER}'

echo "Create the base-pytorch Dockerfile"
dest="base-pytorch/Dockerfile"
mkdir -p "$(dirname "$dest")"
export DOCKER_CUDA_VER=11.4.2
export PYTORCH_CUDA_VER=11.3
export CUDNN_VER=8
export UBUNTU_VERSION=20.04
export BASE="nvidia/cuda:$DOCKER_CUDA_VER-cudnn$CUDNN_VER-devel-ubuntu${UBUNTU_VERSION}"
if [ $# -eq 0 ]
then
    export PYTORCH_VER=''
else
    export PYTORCH_VER="=$1"
fi

envsubst $shell_format < $template > $dest

###############
# Next Docker #
###############
echo "Create the nnx-specific Dockerfile"
dest="nnx-pytorch/Dockerfile"
mkdir -p "$(dirname "$dest")"

if [ $# -gt 0 ]
then
    # Use the docker with the specific PyTorch version
    # - note - this has to be manually built and sent
    #          to the docker hub
    export PYTORCH_VER=":pytorch$1"
fi

export BASE=gforge/base-pytorch
template="Dockerfile_nnx.template"
envsubst $shell_format < $template > $dest
