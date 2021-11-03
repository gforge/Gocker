#!/bin/env bash

pytorch_cuda=$(conda list | grep "^pytorch " | grep cuda | wc -l)

if [[ "$pytorch_cuda" -eq "0" ]]; then
    echo "Failed to install PyTorch with cuda support";
    exit 1;
fi

echo "PyTorch with CUDA support identified"
