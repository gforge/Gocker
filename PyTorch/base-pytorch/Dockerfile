FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04
MAINTAINER Max Gordon <max@gforge.se>

# This package only installs the pre-requisits for later installing torch
# Due to dockerhub limitations it's split into these small pieces

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# Install Python, Jupyter and build tools
RUN apt-get update --fix-missing && apt-get install -y \
    bzip2 \
    build-essential \
    git \
    mercurial \
    subversion \
    software-properties-common \
    wget \
    ca-certificates \
    libglib2.0-0 \
    libssl-dev \
    libsm6 \
    libxext6 \
    libxrender1 \
    curl \
    && rm -rf /var/lib/apt/lists/*

# We want the user with ID 1000 as this is a non-root user and frequently the parent system user
ENV HOME /home/dluser
RUN /usr/sbin/groupadd dluser --gid 1000
RUN useradd -d ${HOME} -u 1000 -o -g dluser dluser
RUN mkdir -p ${HOME}
RUN mkdir -p ${HOME}/code

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
        cudatoolkit=10.0 \
        torchvision \
        jupyter \
        ipywidgets && \
    conda clean --all --yes

CMD ["/bin/bash"]
