FROM gforge/base-pytorch
MAINTAINER Max Gordon <max@gforge.se>

RUN apt-get update \
   && apt-get install -y \
      libgl1-mesa-glx

RUN conda install -y \
   pandas \
   shapely \
   scikit-learn \
   scikit-image \
   matplotlib \
   && conda install -y \
   -c conda-forge \
   blessings \
   tensorboard \
   future \
   pyyaml \
   opencv \
   && conda clean --all --yes

RUN conda install -y -c bioconda ray

# Jupyter config
RUN jupyter notebook --generate-config \
 && printf "\nimport os\nfrom IPython.lib import passwd\npassword = os.environ.get('JUPYTER_PASSWORD')\nif password:\n  c.NotebookApp.password = passwd(password)\n" \
    >> ~/.jupyter/jupyter_notebook_config.py

# Expose Jupyter port
EXPOSE 8888

RUN mkdir /models
# Place to save the models using `torch.utils.model_zoo`
RUN mkdir /models/zoo
ENV TORCH_MODEL_ZOO /models/zoo

# Where to mount the data
RUN mkdir /data && \
    mkdir /data/Imagenet && \
    mkdir /data/xrays && \
    mkdir /data/xrays_alt && \
    mkdir /data/cifar10 && \
    mkdir /data/coco && \
    mkdir /data/log && \
    mkdir /data/annotations

# Set permittions for our dluser directories
RUN chown dluser -R /data && \
    chown dluser -R ${HOME} && \
    chown dluser -R /models/zoo

# Change to user
USER dluser

WORKDIR ${HOME}/code

COPY --chown=dluser resources ${HOME}
# Change to for jupyter CMD ["/root/run_jupyter.sh"]

RUN echo "PS1=\"\${debian_chroot:+(\$debian_chroot)}\u@nnx:\w\$ \"" >> ~/.bashrc

RUN echo ". ~/.bash_aliases" >> ~/.bashrc


CMD ["/bin/bash"]
#  python code/main.py -profile docker -datasets xray_full
