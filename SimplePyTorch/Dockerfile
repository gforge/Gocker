FROM pytorch/pytorch
MAINTAINER Max Gordon <max@gforge.se>

# Install tex converters
RUN apt-get update && apt-get install -y \
  pandoc \
  texlive \
  texlive-latex-extra \
  texlive-latex-recommended \
  texlive-fonts-recommended \
  texlive-xetex


# Expose Jupyter port
EXPOSE 8888

COPY resources /root
CMD ["/root/run_jupyter.sh"]
