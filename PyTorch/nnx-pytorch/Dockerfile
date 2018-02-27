FROM gforge/base-pytorch
MAINTAINER Max Gordon <max@gforge.se>

RUN conda update conda

RUN conda install -y \
   pandas \
   opencv

# Jupyter config
RUN jupyter notebook --generate-config \
 && printf "\nimport os\nfrom IPython.lib import passwd\npassword = os.environ.get('JUPYTER_PASSWORD')\nif password:\n  c.NotebookApp.password = passwd(password)\n" \
    >> ~/.jupyter/jupyter_notebook_config.py

# Expose Jupyter port
EXPOSE 8888

# Set working dir
VOLUME /root/notebook
WORKDIR /root/notebook

COPY resources /root
CMD ["/root/run_jupyter.sh"]
