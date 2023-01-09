#!/usr/bin/env bash

set -e

build_depth=${1:-2}

PYTHON_VER=3.11
PYTORCH_VER=1.13.1
PYTORCH_CUDA_VER=11.7
DOCKER_CUDA_VER="${PYTORCH_CUDA_VER}.0"
CUDNN_VER=8
UBUNTU_VERSION=22.04
BASE_IMAGE="nvidia/cuda"
IMAGE_TAG="${DOCKER_CUDA_VER}-cudnn${CUDNN_VER}-runtime-ubuntu${UBUNTU_VERSION}"
BUILD_IMAGE_TAG="${IMAGE_TAG}-PyTorch${PYTORCH_VER}"

TZ=Europe/Stockholm

star_line() {
  printf "\e[93m"
  for ((i = 1; i <= $1; i++)); do
    printf "*"
  done
  printf "\e[0m\n"
}

line_len=61
star_line $line_len
printf "\e[93m*\e[0m %-57s \e[93m*\e[0m\n" "Building at depth ${build_depth}"
printf "\e[93m*\e[0m %-57s \e[93m*\e[0m\n" "Arguments:"
printf "\e[93m*\e[0m - %-55s \e[93m*\e[0m\n" "PYTORCH_VER=${PYTORCH_VER}"
printf "\e[93m*\e[0m - %-55s \e[93m*\e[0m\n" "PYTORCH_CUDA_VER=${PYTORCH_CUDA_VER}"
printf "\e[93m*\e[0m - %-55s \e[93m*\e[0m\n" "DOCKER_CUDA_VER=${DOCKER_CUDA_VER}"
printf "\e[93m*\e[0m - %-55s \e[93m*\e[0m\n" "CUDNN_VER=${CUDNN_VER}"
printf "\e[93m*\e[0m - %-55s \e[93m*\e[0m\n" "BASE_IMAGE=${BASE_IMAGE}"
printf "\e[93m*\e[0m - %-55s \e[93m*\e[0m\n" "IMAGE_TAG=${IMAGE_TAG}"
printf "\e[93m*\e[0m - %-55s \e[93m*\e[0m\n" "TZ=${TZ}"
printf "\e[93m*\e[0m %-57s \e[93m*\e[0m\n" "build to ${BUILD_IMAGE_TAG}"
star_line $line_len

NNX_BASE_IMAGE_NAME=gforge/base-pytorch
NNX_TARGET_IMAGE=gforge/nnx-pytorch
if [ $build_depth -ge 2 ]; then
  printf "\n"
  star_line 52
  printf "\e[93m*\e[0m %-48s \e[93m*\e[0m\n" "Building base nvidia docker ${NNX_BASE_IMAGE_NAME}"
  star_line 52

  sudo docker build \
    -t $NNX_BASE_IMAGE_NAME:$BUILD_IMAGE_TAG \
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
    -t $NNX_TARGET_IMAGE:$BUILD_IMAGE_TAG \
    --build-arg BASE_IMAGE=$NNX_BASE_IMAGE_NAME \
    --build-arg BUILD_IMAGE_TAG=$BUILD_IMAGE_TAG \
    nnx-pytorch
fi
