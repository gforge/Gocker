#!/usr/bin/env bash

# Get latest commit hashes for Git repositories used in the image
export LATEST_TORCH_DISTRO_COMMIT=`git ls-remote -h https://github.com/torch/distro.git master | awk '{ print $1 }'`

################
# First Docker #
################

# Create Dockerfiles from template
template="Dockerfile_base.template"
shell_format='$BASE:$LATEST_TORCH_DISTRO_COMMIT'

echo "Create the base-torch Dockerfile"
dest="base-torch/Dockerfile"
mkdir -p "$(dirname "$dest")"
export BASE=nvidia/cuda:8.0-cudnn5-devel

envsubst $shell_format < $template > $dest

###############
# Next Docker #
###############
echo "Create the extend-torch Dockerfile"
dest="torch/Dockerfile"
mkdir -p "$(dirname "$dest")"

export BASE=gforge/nvidia-torch-base
template="Dockerfile_torch.template"

envsubst $shell_format < $template > $dest

###############
# Next Docker #
###############
echo "Create the extend-torch Dockerfile"
dest="extend-torch/Dockerfile"
mkdir -p "$(dirname "$dest")"

export BASE=gforge/base-torch
template="Dockerfile_extend.template"

envsubst $shell_format < $template > $dest

###############
# Next Docker #
###############
echo "Create the nnx-specific Dockerfile"
dest="nnx-torch/Dockerfile"
mkdir -p "$(dirname "$dest")"

export BASE=gforge/extend-torch
template="Dockerfile_nnx.template"
envsubst $shell_format < $template > $dest
