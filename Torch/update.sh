#!/bin/bash -e

# Get latest commit hashes for Git repositories used in the image
export LATEST_TORCH_DISTRO_COMMIT=`git ls-remote -h https://github.com/torch/distro.git master | awk '{ print $1 }'`

# Create Dockerfiles from template
template="Dockerfile_base.template"
shell_format='$BASE:$LATEST_TORCH_DISTRO_COMMIT'

echo "Create the base-torch Dockerfile"
dest="base-torch/Dockerfile"
mkdir -p "$(dirname "$dest")"
export BASE=nvidia/cuda:7.5-cudnn4-devel

envsubst $shell_format < $template > $dest

echo "Create the nnx-specific Dockerfile"
dest="nnx-torch/Dockerfile"
mkdir -p "$(dirname "$dest")"

export BASE=gforge/nnx-base
template="Dockerfile_nnx.template"
envsubst $shell_format < $template > $dest

