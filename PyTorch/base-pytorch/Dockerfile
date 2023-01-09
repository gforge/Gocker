ARG BASE_IMAGE
ARG IMAGE_TAG
FROM ${BASE_IMAGE}:${IMAGE_TAG}
LABEL maintainer="Max Gordon <max@gforge.se>"

# This package only installs the pre-requisits for later installing torch
# Due to dockerhub limitations it's split into these small pieces

# Avoid timezone issue
ARG TZ=Europe/Stockholm
RUN ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime

# Avoid stops in apt install
ENV DEBIAN_FRONTEND=noninteractive

# Install Python, Jupyter and build tools
# - Already installed
#   build-essential
#   ca-certificates
RUN apt-get update --fix-missing && \
    apt-get install -y --no-install-recommends \
    bzip2 \
    git \
    mercurial \
    software-properties-common \
    wget \
    libglib2.0-0 \
    libssl-dev \
    libsm6 \
    libxext6 \
    libxrender1 \
    curl \
    locales \
    nano \
    libgl1-mesa-glx \
    libopencv-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# ENV LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN echo "LANG=en_US.UTF-8" > /etc/locale.conf
RUN locale-gen en_US.UTF-8

# We want the user with ID 1000 as this is a non-root user and frequently the parent system user
ENV HOME /home/dluser
RUN /usr/sbin/groupadd dluser --gid 1000
RUN useradd -d ${HOME} -u 1000 -o -g dluser dluser
RUN mkdir -p ${HOME}
RUN mkdir -p ${HOME}/code

WORKDIR ${HOME}
COPY --chown=dluser resources ${HOME}

# Install miniconda to /miniconda
RUN mkdir -p /opt
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ${HOME}/miniconda.sh && \
    /bin/bash ${HOME}/miniconda.sh -b -p /opt/conda && \
    rm ${HOME}/miniconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ${HOME}/.bashrc && \
    echo "conda activate base" >> ${HOME}/.bashrc

ENV PATH=/opt/conda/bin:${PATH}

ARG PYTHON_VER
ARG PYTORCH_VER
ARG PYTORCH_CUDA_VER
RUN conda config --add channels conda-forge && \
    conda config --add channels pytorch && \
    conda config --add channels nvidia && \
    conda install python=$PYTHON_VER && \
    conda update -y --all && \
    conda install -y \
    pytorch$PYTORCH_VER \
    pytorch-cuda=$PYTORCH_CUDA_VER \
    torchvision \
    jupyter \
    ipywidgets && \
    conda clean -afy

# Verify that CUDA is available as expected
RUN ./check_pytorch_cuda.sh

CMD ["/bin/bash"]
