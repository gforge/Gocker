#!/usr/bin/env bash

set -e

# Run with root privileges, i.e. sudo
build_depth=${1:-2}

echo -e "\e[93m***********************\e[0m"
echo -e "\e[93m*\e[0m Building at depth ${build_depth} \e[93m*\e[0m"
echo -e "\e[93m***********************\e[0m"

if [ $build_depth -ge 2 ]; then
  echo -e "\e[93m*******************************\e[0m"
  echo -e "\e[93m*\e[0m Building base nvidia docker \e[93m*\e[0m"
  echo -e "\e[93m*******************************\e[0m"
  sudo docker build -t gforge/base-pytorch base-pytorch/
fi

if [ $build_depth -ge 1 ]; then
  echo -e "\e[93m*******************************\e[0m"
  echo -e "\e[93m*\e[0m Building nnx pytorch docker \e[93m*\e[0m"
  echo -e "\e[93m*******************************\e[0m"
  sudo docker build -t gforge/nnx-pytorch nnx-pytorch/
fi
