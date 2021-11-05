ARG BASE_IMAGE
ARG IMAGE_TAG
FROM ${BASE_IMAGE}:${IMAGE_TAG}
LABEL maintainer="Max Gordon <max@gforge.se>"

# Avoid timezone issue
ENV TZ=Europe/Stockholm
RUN ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime

# Avoid stops in apt install
ENV DEBIAN_FRONTEND=noninteractive

########################
# Extra conda installs #
########################

RUN conda install -y \
    pandas \
    datatable \
    shapely \
    scikit-learn \
    scikit-image \
    matplotlib \
    blessings \
    future \
    pyyaml \
    opencv \
    objgraph \
    && conda install -y -c bioconda ray \
    && conda clean --all --yes

####################################
# User that we want to use         #
#  - should still be replacesd     #
#    with --user $(id -u):$(id -g) #
#    during "docker run"           #
#    but this is a cheap a way of  #
#    avoiding defaulting to root   #
####################################

ENV HOME /home/dluser
RUN /usr/sbin/groupadd dluser --gid 1000
RUN useradd -d ${HOME} -u 1000 -o -g dluser dluser
RUN mkdir -p ${HOME}
RUN mkdir -p ${HOME}/code

WORKDIR ${HOME}
COPY --chown=dluser resources ${HOME}

####################
# Core directories #
####################

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

###############
# Final setup #
###############

# Change to user
USER dluser

WORKDIR ${HOME}/code

RUN curl -L https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh > ~/.bash_git
RUN echo "PS1='\[\033[0;32m\]\[\033[0m\033[0;32m\]\u\[\033[0;36m\] @ \[\033[0;36m\]\h \w\[\033[0;32m\]$(__git_ps1)\n\[\033[0;32m\]└─\[\033[0m\033[0;32m\] \$\[\033[0m\033[0;32m\] ▶\[\033[0m\] '" >> ~/.bashrc
