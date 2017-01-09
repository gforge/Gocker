#!/usr/bin/env bash

set -e

# Run with root privileges, i.e. sudo
build_depth=${1:-4}

echo -e "\e[93m***********************\e[0m"
echo -e "\e[93m*\e[0m Building at depth ${build_depth} \e[93m*\e[0m"
echo -e "\e[93m***********************\e[0m"

if [ $build_depth -ge 4 ]; then
  echo -e "\e[93m*******************************\e[0m"
  echo -e "\e[93m*\e[0m Building base nvidia docker \e[93m*\e[0m"
  echo -e "\e[93m*******************************\e[0m"
  docker build -t gforge/nvidia-torch-base base-torch/
fi

if [ $build_depth -ge 3 ]; then
  echo -e "\e[93m*******************************\e[0m"
  echo -e "\e[93m*\e[0m Building base torch docker \e[93m*\e[0m"
  echo -e "\e[93m*******************************\e[0m"
  docker build -t gforge/base-torch torch/
fi

if [ $build_depth -ge 2 ]; then
  echo -e "\e[93m*******************************\e[0m"
  echo -e "\e[93m*\e[0m Building ext. torch docker \e[93m*\e[0m"
  echo -e "\e[93m*******************************\e[0m"
  docker build -t gforge/extend-toch extend-torch/
fi

if [ $build_depth -ge 1 ]; then
  echo -e "\e[93m*******************************\e[0m"
  echo -e "\e[93m*\e[0m Building nnx torch docker \e[93m*\e[0m"
  echo -e "\e[93m*******************************\e[0m"
  docker build -t gforge/nnx-torch nnx-torch/
fi


