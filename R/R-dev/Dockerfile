FROM rocker/r-devel
MAINTAINER "Max Gordon" max@gforge.se

## Remain current
RUN apt-get update \
  && apt-get upgrade -y

RUN apt-get update \
  && apt-get install -y  \
    bash-completion \
    bison \
    debhelper \
    default-jdk \
    g++ \
    gcc \
    gdb \
    gfortran \
    groff-base \
    libblas-dev \
    libbz2-dev \
    libcairo2-dev \
    libcurl4-openssl-dev \
    libjpeg-dev \
    liblapack-dev \
    liblzma-dev \
    libncurses5-dev \
    libpango1.0-dev \
    libpcre3-dev \
    libpng-dev \
    libreadline-dev \
    libtiff5-dev \
    libx11-dev \
    libxt-dev \
    mpack \
    subversion \
    tcl8.6-dev \
    icedtea-netx \
    libatlas-base-dev \
    libcairo2-dev \
    libgsl0-dev \
    libgdal-dev \
    libgeos-dev \
    libssl-dev \
    libpq-dev \
    libsqlite3-0 \
    libsqlite3-dev \
    libv8-dev \
    libxcb1-dev \
    libxdmcp-dev \
    libxml2-dev \
    libxslt1-dev \
    libxt-dev \
    netcdf-bin \
    qpdf \
    ssh

RUN install2.r -d TRUE \
    devtools \
    htmlTable \
    Gmisc \
    forestplot \
    ggplot2 \
    dplyr \
    magrittr \
    plyr \
    cmprsk \
    testthat \
    rms \
    sandwich \
    Epi \
    lattice \
    survival \
    cluster \
    parallel \
    foreign \
    nnet \
    rpart \
    MASS \
    nlme \
    rmeta \
    pxweb \
    pander \
    Matrix \
    checkmate \
    lattice \
    codetools

RUN install2.r -d TRUE \
    chron \
    lubridate

RUN apt-get install -y \
    pandoc \
    pandoc-citeproc \
    nano

COPY resources /root
WORKDIR "/root"

CMD ["/bin/bash"]
