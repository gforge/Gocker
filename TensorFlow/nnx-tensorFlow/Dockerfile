FROM tensorflow/tensorflow:nightly-gpu-py3
MAINTAINER Jakub Niob & Max Gordon

#################
# Update python #
#################

RUN apt update
RUN apt upgrade -y

##############################################
# Specific libraries used in the nnx-project #
##############################################
# test/./run_tf_docker.sh
# ADD ./test /notebooks

# Set working dir
VOLUME /root/notebook
WORKDIR /root/notebook

# Install packages
RUN pip3 install --upgrade pip
RUN pip3 install matplotlib
RUN pip3 install keras

# Add PyTorch
RUN pip3 install https://s3.amazonaws.com/pytorch/whl/cu80/torch-0.1.9.post2-cp35-cp35m-linux_x86_64.whl
RUN pip3 install torchvision

# Jupyter config
#RUN jupyter notebook --generate-config \
RUN printf "\nimport os\nfrom IPython.lib import passwd\npassword = os.environ.get('JUPYTER_PASSWORD')\nif password:\n  c.NotebookApp.password = passwd(password)\n" \
   >> ~/.jupyter/jupyter_notebook_config.py

# tensorboard
EXPOSE 6006

# Expose Jupyter port
EXPOSE 8888

COPY resources /root
CMD ["/root/run_jupyter.sh"]
