#!/usr/bin/env bash

set -e

build_depth=${1:-2}

PYTHON_VER=3.10
PYTORCH_CUDA_VER=11.7
DOCKER_CUDA_VER=11.8.0
CUDNN_VER=8
UBUNTU_VERSION=22.04
BASE_IMAGE="nvidia/cuda"
IMAGE_TAG="$DOCKER_CUDA_VER-cudnn$CUDNN_VER-runtime-ubuntu${UBUNTU_VERSION}"

TZ=Europe/Stockholm

star_line() {
  printf "\e[93m"
  for ((i = 1; i <= $1; i++)); do
    printf "*"
  done
  printf "\e[0m\n"
}

star_line 49
printf "\e[93m*\e[0m %-45s \e[93m*\e[0m\n" "Building at depth ${build_depth}"
printf "\e[93m*\e[0m %-45s \e[93m*\e[0m\n" "Arguments:"
printf "\e[93m*\e[0m - %-43s \e[93m*\e[0m\n" "PYTORCH_CUDA_VER=${PYTORCH_CUDA_VER}"
printf "\e[93m*\e[0m - %-43s \e[93m*\e[0m\n" "DOCKER_CUDA_VER=${DOCKER_CUDA_VER}"
printf "\e[93m*\e[0m - %-43s \e[93m*\e[0m\n" "CUDNN_VER=${CUDNN_VER}"
printf "\e[93m*\e[0m - %-43s \e[93m*\e[0m\n" "BASE_IMAGE=${BASE_IMAGE}"
printf "\e[93m*\e[0m - %-43s \e[93m*\e[0m\n" "IMAGE_TAG=${IMAGE_TAG}"
printf "\e[93m*\e[0m - %-43s \e[93m*\e[0m\n" "TZ=${TZ}"
star_line 49

NNX_BASE_IMAGE_NAME=gforge/base-pytorch
NNX_TARGET_IMAGE=gforge/nnx-pytorch
if [ $build_depth -ge 2 ]; then
  printf "\n"
  star_line 52
  printf "\e[93m*\e[0m %-48s \e[93m*\e[0m\n" "Building base nvidia docker ${NNX_BASE_IMAGE_NAME}"
  star_line 52

  sudo docker build \
    -t $NNX_BASE_IMAGE_NAME:$IMAGE_TAG \
    --build-arg BASE_IMAGE=$BASE_IMAGE \
    --build-arg IMAGE_TAG=$IMAGE_TAG \
    --build-arg PYTHON_VER=$PYTHON_VER \
    --build-arg PYTORCH_CUDA_VER=$PYTORCH_CUDA_VER \
    --build-arg TZ=$TZ \
    base-pytorch
fi

if [ $build_depth -ge 1 ]; then
  printf "\n"
  star_line 52
  printf "\e[93m*\e[0m %-48s \e[93m*\e[0m\n" "Building target docker ${NNX_TARGET_IMAGE}"
  star_line 52

  sudo docker build \
    -t $NNX_TARGET_IMAGE:$IMAGE_TAG \
    --build-arg BASE_IMAGE=$NNX_BASE_IMAGE_NAME \
    --build-arg IMAGE_TAG=$IMAGE_TAG \
    nnx-pytorch
fi
