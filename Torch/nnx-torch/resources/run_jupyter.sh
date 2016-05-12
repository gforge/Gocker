#!/usr/bin/env bash
# It is good to get basic stats on the cards in the container
nvidia-smi

# Now start the notebook
jupyter notebook --no-browser --ip=0.0.0.0
