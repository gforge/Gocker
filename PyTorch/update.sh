#!/usr/bin/env bash

################
# First Docker #
################

# Create Dockerfiles from template
template="Dockerfile_base.template"
shell_format='$BASE'

echo "Create the base-pytorch Dockerfile"
dest="base-pytorch/Dockerfile"
mkdir -p "$(dirname "$dest")"
export BASE=nvidia/cuda:10.0-cudnn7-devel-ubuntu16.04

envsubst $shell_format < $template > $dest

###############
# Next Docker #
###############
echo "Create the nnx-specific Dockerfile"
dest="nnx-pytorch/Dockerfile"
mkdir -p "$(dirname "$dest")"

export BASE=gforge/base-pytorch
template="Dockerfile_nnx.template"
envsubst $shell_format < $template > $dest
