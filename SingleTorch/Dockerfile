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
    tini \
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

ENV CONDA_DIR=/opt/conda
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

ARG MINIFORGE_NAME=Miniforge3
ARG MINIFORGE_VERSION=22.9.0-1
ARG TARGETPLATFORM=x86_64

# Install miniconda to /miniconda
ENV PATH="${CONDA_DIR}/bin:${PATH}"
RUN mkdir -p /opt
RUN wget --no-hsts --quiet https://github.com/conda-forge/miniforge/releases/download/${MINIFORGE_VERSION}/${MINIFORGE_NAME}-${MINIFORGE_VERSION}-Linux-$(uname -m).sh -O /tmp/miniforge.sh && \
    /bin/bash /tmp/miniforge.sh -b -p ${CONDA_DIR} && \
    rm /tmp/miniforge.sh && \
    conda clean --tarballs --index-cache --packages --yes && \
    find ${CONDA_DIR} -follow -type f -name '*.a' -delete && \
    find ${CONDA_DIR} -follow -type f -name '*.pyc' -delete && \
    conda clean --force-pkgs-dirs --all --yes  && \
    echo ". ${CONDA_DIR}/etc/profile.d/conda.sh && conda activate base" >> /etc/skel/.bashrc && \
    echo ". ${CONDA_DIR}/etc/profile.d/conda.sh && conda activate base" >> ~/.bashrc

ARG PYTHON_VER
ARG PYTORCH_VER
ARG PYTORCH_CUDA_VER
RUN conda install python=$PYTHON_VER && \
    conda config --add channels pytorch && \
    conda config --add channels nvidia && \
    conda config --add channels bioconda && \
    conda update -y --all && \
    conda install -y \
    pytorch$PYTORCH_VER \
    pytorch-cuda=$PYTORCH_CUDA_VER \
    pandas \
    tensorboard \
    future \
    pyyaml \
    objgraph \
    pydantic \
    scikit-learn \
    scikit-image \
    ray && \
    conda clean -afy

# Verify that CUDA is available as expected
RUN ./check_pytorch_cuda.sh

# A ray reature
ENV OMPI_MCA_opal_cuda_support true

# Data directory
ENV DATA_DIR /data
# Home of all models
ENV TORCH_MODELS /models
# Place to save the models using `torch.utils.model_zoo`
ENV TORCH_MODEL_ZOO "${TORCH_MODELS}/zoo"

# Where to mount the data
RUN mkdir ${DATA_DIR} && \
    mkdir "${DATA_DIR}/Imagenet" && \
    mkdir "${DATA_DIR}/xrays" && \
    mkdir "${DATA_DIR}/xrays_alt" && \
    mkdir "${DATA_DIR}/cifar10" && \
    mkdir "${DATA_DIR}/coco" && \
    mkdir "${DATA_DIR}/log" && \
    mkdir "${DATA_DIR}/annotations" && \
    mkdir ${TORCH_MODELS} && \
    mkdir ${TORCH_MODEL_ZOO}

# Set permittions for our dluser directories
RUN chown dluser -R ${HOME} && \
    chown dluser -R ${DATA_DIR} && \
    chown dluser -R ${TORCH_MODELS}

# Change to user
USER dluser

# Packages that failed regular conda install
RUN pip install --no-cache-dir \
    matplotlib \
    opencv-python \
    blessings

WORKDIR ${HOME}/code

# Change to for jupyter CMD ["/root/run_jupyter.sh"]

RUN echo "PS1=\"\${debian_chroot:+(\$debian_chroot)}\u@nnx:\w\$ \"" >> ~/.bashrc

CMD ["/bin/bash"]
