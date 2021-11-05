#!/usr/bin/env bash

set -e

BASE_IMAGE="nvcr.io/nvidia/pytorch"
IMAGE_TAG="21.10-py3"
DEST="gforge/ngc-pytorch:${IMAGE_TAG}"

printf "Building from \e[93m${BASE_IMAGE}:${IMAGE_TAG}\e[0m to \e[93m${DEST}\e[0m\n"

sudo docker build \
  -t $DEST \
  --build-arg BASE_IMAGE=$BASE_IMAGE \
  --build-arg IMAGE_TAG=$IMAGE_TAG \
  nnx-ngc-pytorch
