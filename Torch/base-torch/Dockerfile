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
ARG TORCH_DISTRO_COMMIT=2f020918f561c108bb5b95e561b63dbbe635ec62
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

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add findCUDA so that we don't get all those THC errors
RUN luarocks install findCUDA

# Install Moses for utilities for better array handling
RUN luarocks install moses

# Install torch-autograd, rnn and unsup
RUN luarocks install autograd
RUN luarocks install rnn
RUN luarocks install unsup

# Install dataset
RUN luarocks install dataset


# Install distlearn
RUN luarocks install distlearn

# Install classic
RUN luarocks install classic

# Install torchx
RUN luarocks install torchx

# Install dpnn
RUN luarocks install dpnn

# Install nninit
RUN luarocks install nninit

CMD ["/bin/bash"]

