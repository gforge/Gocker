FROM nvidia/cuda:7.5-cudnn4-devel
MAINTAINER Max Gordon <max@gforge.se>

# Install Python, Jupyter and build tools
RUN apt-get update && apt-get install -y \
    python3 \
    python3-setuptools \
    python3-dev \
    ipython3 \
    build-essential \
    git
RUN easy_install3 pip \
 && pip install 'notebook>=4.1.0' jupyter ipywidgets

# Run Torch7 installation scripts (dependencies only)
ARG TORCH_DISTRO_COMMIT=ba34004a7a48806bf4a6e88ecfc5fbada5efe636
RUN git clone https://github.com/torch/distro.git /root/torch --recursive && cd /root/torch

RUN apt-get install -y \
  software-properties-common \
  libssl-dev
RUN cd /root/torch \
 && git checkout "$TORCH_DISTRO_COMMIT" \
 && bash install-deps

# Run Torch7 installation scripts
RUN cd /root/torch \
 && ./install.sh

# Export environment variables manually
ENV LUA_PATH='/root/.luarocks/share/lua/5.1/?.lua;/root/.luarocks/share/lua/5.1/?/init.lua;/root/torch/install/share/lua/5.1/?.lua;/root/torch/install/share/lua/5.1/?/init.lua;./?.lua;/root/torch/install/share/luajit-2.1.0-alpha/?.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua' \
    PATH=/root/torch/install/bin:$PATH \
    LD_LIBRARY_PATH=/root/torch/install/lib:$LD_LIBRARY_PATH \
    DYLD_LIBRARY_PATH=/root/torch/install/lib:$DYLD_LIBRARY_PATH \
    LUA_CPATH='/root/.luarocks/lib/lua/5.1/?.so;/root/torch/install/lib/lua/5.1/?.so;./?.so;/usr/local/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/loadall.so'

# Install Moses for utilities
RUN luarocks install moses

# Install CSV parser
RUN luarocks install csv

# Install torch-autograd, rnn and unsup
RUN luarocks install autograd
RUN luarocks install rnn
RUN luarocks install unsup

# Install HTTP client
RUN luarocks install httpclient

RUN luarocks install luaposix

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

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
