#!/usr/bin/env bash

echo -e "\e[93m*******************************\e[0m"
echo -e "\e[93m*\e[0m Building base nvidia docker \e[93m*\e[0m"
echo -e "\e[93m*******************************\e[0m"
sudo docker build -t gforge/nvidia-torch-base base-torch/

echo -e "\e[93m*******************************\e[0m"
echo -e "\e[93m*\e[0m Building base torch docker \e[93m*\e[0m"
echo -e "\e[93m*******************************\e[0m"
sudo docker build -t gforge/base-torch torch/

echo -e "\e[93m*******************************\e[0m"
echo -e "\e[93m*\e[0m Building ext. torch docker \e[93m*\e[0m"
echo -e "\e[93m*******************************\e[0m"
sudo docker build -t gforge/extend-base extend-torch/

echo -e "\e[93m*******************************\e[0m"
echo -e "\e[93m*\e[0m Building nnx torch docker \e[93m*\e[0m"
echo -e "\e[93m*******************************\e[0m"
sudo docker build -t gforge/nnx-torch nnx-torch/
