FROM rocker/r-devel
MAINTAINER "Max Gordon" max@gforge.se

## Remain current
RUN apt-get update \
  && apt-get upgrade -y

RUN apt-get update

RUN apt-get install -y  \
    bash-completion \
    bison \
    debhelper \
    default-jdk \
    g++ \
    gcc \
    gdb \
    gfortran \
    groff-base \
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
    libicu-dev \
    ssh

# The blas & atlas libraries seem 2 be problematic (reduced to libblas)
RUN apt-get install \
    libblas-dev

# TODO: figure out how install packages specifically to RD
# RUN cp /usr/local/bin/install2.r /usr/local/bin/install2.rd
# RUN cp /usr/local/bin/install.r /usr/local/bin/install.rd
# RUN sed -i "1s/r$/RDscript/" /usr/local/bin/install2.rd
# RUN sed -i "s/install2.r/install2.rd/" /usr/local/bin/install2.rd
# RUN sed -i "1s/r$/RDscript/" /usr/local/bin/install.rd
# RUN sed -i "s/install.r/install.rd/" /usr/local/bin/install.rd

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
