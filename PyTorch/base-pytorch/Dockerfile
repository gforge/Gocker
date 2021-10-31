FROM nvidia/cuda:11.4.2-cudnn8-devel-ubuntu20.04
LABEL maintainer="Max Gordon <max@gforge.se>"

# This package only installs the pre-requisits for later installing torch
# Due to dockerhub limitations it's split into these small pieces

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
    && rm -rf /var/lib/apt/lists/*

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

RUN conda config --add channels conda-forge && \
    conda config --add channels pytorch && \
    conda update -y --all && \
    conda install -y \
        pytorch \
        cudatoolkit=11.4.2 \
        torchvision \
        jupyter \
        ipywidgets && \
    conda clean -afy

CMD ["/bin/bash"]
