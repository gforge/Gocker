FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu16.04
MAINTAINER Max Gordon <max@gforge.se>

# This package only installs the pre-requisits for later installing torch
# Due to dockerhub limitations it's split into these small pieces

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# Install Python, Jupyter and build tools
RUN apt-get update --fix-missing && apt-get install -y \
    bzip2 \
    python3 \
    python3-setuptools \
    python3-dev \
    ipython3 \
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
    libxrender1


# Install miniconda to /miniconda
RUN curl -LO http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh
RUN bash Miniconda-latest-Linux-x86_64.sh -p /miniconda -b
RUN rm Miniconda-latest-Linux-x86_64.sh
ENV PATH=/miniconda/bin:${PATH}
RUN conda update -y conda

# Old miniconda
#RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
#  wget --quiet https://repo.continuum.io/miniconda/Miniconda3-4.3.27-Linux-x86_64.sh -O ~/miniconda.sh && \
#  /bin/bash ~/miniconda.sh -b -p /opt/conda && \
#  rm ~/miniconda.sh

ENV PATH /opt/conda/bin:$PATH

RUN conda config --add channels conda-forge
RUN conda config --add channels pytorch

RUN conda update -y --all
RUN conda install pytorch torchvision -c pytorch -y
RUN conda install jupyter ipywidgets -y

CMD ["/bin/bash"]
