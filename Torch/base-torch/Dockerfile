FROM nvidia/cuda:8.0-cudnn5-devel
MAINTAINER Max Gordon <max@gforge.se>

# This package only installs the pre-requisits for later installing torch
# Due to dockerhub limitations it's split into these small pieces

# Install Python, Jupyter and build tools
RUN apt-get update && apt-get install -y \
    python3 \
    python3-setuptools \
    python3-dev \
    ipython3 \
    build-essential \
    git
RUN easy_install3 pip \
 && pip install jupyter ipywidgets

# Run Torch7 installation scripts (dependencies only)
ARG TORCH_DISTRO_COMMIT=e21ee70861fb78aa147757b5ed64755f30391637
RUN git clone https://github.com/torch/distro.git /root/torch --recursive && cd /root/torch

RUN apt-get install -y \
  software-properties-common \
  libssl-dev
RUN cd /root/torch \
 && git checkout "$TORCH_DISTRO_COMMIT" \
 && bash install-deps

CMD ["/bin/bash"]
