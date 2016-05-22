FROM gforge/base-torch
MAINTAINER Max Gordon <max@gforge.se>

# Add findCUDA so that we don't get all those THC errors
RUN luarocks install findCUDA

# Install Moses for utilities for better array handling
RUN luarocks install moses

# Install torch-autograd, rnn and unsup
RUN luarocks install autograd
RUN luarocks install rnn
RUN luarocks install unsup

# Install distlearn
RUN luarocks install distlearn

# Install torchx
RUN luarocks install torchx

# Install dpnn
RUN luarocks install dpnn

# Install nninit
RUN luarocks install nninit

CMD ["/bin/bash"]
