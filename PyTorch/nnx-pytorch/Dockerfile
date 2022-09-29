ARG BASE_IMAGE
ARG IMAGE_TAG
FROM ${BASE_IMAGE}:${IMAGE_TAG}
LABEL maintainer="Max Gordon <max@gforge.se>"

RUN conda install -y \
    pandas \
    pyarrow \
    shapely \
    scikit-learn \
    scikit-image \
    matplotlib \
    blessings \
    tensorboard \
    future \
    pyyaml \
    opencv \
    objgraph \
    pydantic \
    datatable \
    && conda install -y -c bioconda ray \
    && conda clean --all --yes

# A ray reature
ENV OMPI_MCA_opal_cuda_support true

# Jupyter config
RUN jupyter notebook --generate-config \
    && printf "\nimport os\nfrom IPython.lib import passwd\npassword = os.environ.get('JUPYTER_PASSWORD')\nif password:\n  c.NotebookApp.password = passwd(password)\n" \
    >> ~/.jupyter/jupyter_notebook_config.py

# Expose Jupyter port
EXPOSE 8888

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

WORKDIR ${HOME}/code

# Change to for jupyter CMD ["/root/run_jupyter.sh"]

RUN echo "PS1=\"\${debian_chroot:+(\$debian_chroot)}\u@nnx:\w\$ \"" >> ~/.bashrc

CMD ["/bin/bash"]
