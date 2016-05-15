FROM gforge/nvidia-torch
MAINTAINER Max Gordon <max@gforge.se>

# Install Moses for utilities
RUN luarocks install moses

# Install CSV parser
RUN luarocks install csv

# Install torch-autograd, rnn and unsup
RUN luarocks install autograd
RUN luarocks install rnn
RUN luarocks install unsup

##############################################
# Specific libraries used in the nnx-project #
##############################################
RUN luarocks install findCUDA
RUN luarocks install nn
RUN luarocks install cutorch
RUN luarocks install cunn
RUN luarocks install ccn2
RUN luarocks install cudnn

# My own custom ignore function
RUN luarocks install https://raw.githubusercontent.com/gforge/criterion_ignore/master/criterion_ignore-0.1-1.rockspec

# My and Alex' dataframe
RUN luarocks install https://raw.githubusercontent.com/AlexMili/torch-dataframe/master/rocks/torch-dataframe-scm-1.rockspec

# Install loadcaffe dependencies
RUN apt-get update && apt-get install -y \
  libprotobuf-dev \
  protobuf-compiler
# Install loadcaffe
RUN luarocks install loadcaffe

# DeepMind's hdf5
RUN apt-get install -y \
    libhdf5-serial-dev \
    hdf5-tools
RUN luarocks install https://raw.githubusercontent.com/deepmind/torch-hdf5/master/hdf5-0-0.rockspec LIBHDF5_LIBDIR="/usr/lib/x86_64-linux-gnu/"

# - Libraries that are probably nice to have
# Install parallel
RUN luarocks install optim

# Install parallel
RUN luarocks install parallel

# Install distlearn
RUN luarocks install distlearn

# Install classic
RUN luarocks install classic

# Install torchx
RUN luarocks install torchx

# Install autograd
RUN luarocks install autograd

# Install dataset
RUN luarocks install dataset

# Install dpnn
RUN luarocks install dpnn

# Install nninit
RUN luarocks install nninit

# Install nnquery
RUN apt-get install -y graphviz
RUN luarocks install https://raw.githubusercontent.com/bshillingford/nnquery/master/rocks/nnquery-scm-1.rockspec

# Install rnn
RUN luarocks install rnn

# Install iTorch
RUN luarocks install itorch

# Install csvigo
RUN luarocks install csvigo
RUN luarocks install luafilesystem
RUN luarocks install argcheck

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
