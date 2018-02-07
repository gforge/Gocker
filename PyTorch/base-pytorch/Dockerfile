FROM nvidia/cuda:9.1-cudnn7-devel
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

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
  wget --quiet https://repo.continuum.io/miniconda/Miniconda3-4.3.27-Linux-x86_64.sh -O ~/miniconda.sh && \
  /bin/bash ~/miniconda.sh -b -p /opt/conda && \
  rm ~/miniconda.sh

 RUN apt-get install -y curl grep sed dpkg && \
  TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
  curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
  dpkg -i tini.deb && \
  rm tini.deb && \
  apt-get clean

ENV PATH /opt/conda/bin:$PATH

RUN conda install pytorch torchvision cuda90 -c pytorch
RUN conda install jupyter ipywidgets

CMD ["/bin/bash"]
