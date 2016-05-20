FROM gforge/base-torch
MAINTAINER Max Gordon <max@gforge.se>

# - Libraries that are probably nice to have
# Install parallel
RUN luarocks install optim

# Install parallel
RUN luarocks install parallel

# Install iTorch
RUN luarocks install itorch

##############################################
# Specific libraries used in the nnx-project #
##############################################
# My own custom ignore function
RUN luarocks install https://raw.githubusercontent.com/gforge/criterion_ignore/master/criterion_ignore-0.1-1.rockspec

# Install prereq. for torch-dataframe
RUN luarocks install csvigo
RUN luarocks install luafilesystem
RUN luarocks install argcheck
RUN luarocks install busted

# My and Alex' torch-dataframe
RUN cd /root && \
   git clone https://github.com/AlexMili/torch-dataframe.git && \
   cd /root/torch-dataframe && \
   git checkout develop
   
RUN cd /root/torch-dataframe && \ 
    luarocks make ./rocks/torch-dataframe-scm-1.rockspec

# Change to this for stable release: RUN git clone  install https://raw.githubusercontent.com/AlexMili/torch-dataframe/master/rocks/torch-dataframe-scm-1.rockspec

# Possibly useful for loadcaffe
# Skip for now: RUN luarocks install ccn2

# Install loadcaffe dependencies
RUN apt-get update && apt-get install -y \
  libprotobuf-dev \
  protobuf-compiler
# Install loadcaffe
RUN luarocks install loadcaffe

# Set working dir
VOLUME /root/notebook
WORKDIR /root/notebook

# Jupyter config
RUN jupyter notebook --generate-config \
 && printf "\nimport os\nfrom IPython.lib import passwd\npassword = os.environ.get('JUPYTER_PASSWORD')\nif password:\n  c.NotebookApp.password = passwd(password)\n" \
    >> ~/.jupyter/jupyter_notebook_config.py

# Expose Jupyter port
EXPOSE 8888

COPY resources /root
CMD ["/root/run_jupyter.sh"]
