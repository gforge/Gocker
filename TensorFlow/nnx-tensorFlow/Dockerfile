## Jobbar på denna

FROM tensorflow/tensorflow
MAINTAINER Jakub Niob

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
VOLUME /root/notebooks
WORKDIR /root/notebooks

# Install packages
RUN pip install --upgrade pip
RUN pip install matplotlib
RUN pip install sklearn

# Jupyter config
# RUN jupyter notebook --generate-config \
# && printf "\nimport os\nfrom IPython.lib import passwd\npassword = os.environ.get('JUPYTER_PASSWORD')\nif password:\n  c.NotebookApp.password = passwd(password)\n" \
#    >> ~/.jupyter/jupyter_notebook_config.py

# Expose Jupyter port
EXPOSE 8888

COPY resources /root
CMD ["/root/run_jupyter.sh"]
