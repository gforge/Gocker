### PyTorch Docker image

Ubuntu 16.04 + PyTorch + CUDA + cuDNN

#### Requirements

In order to use this image you must have Docker Engine installed. Instructions for setting up Docker Engine are [available on the Docker website](https://docs.docker.com/engine/installation/).

#### Building

This image can be built on top of multiple different base images derived from Ubuntu 14.04. Which base you choose depends on whether you have an NVIDIA graphics card which supports CUDA and you want to use GPU acceleration or not.

If you are running Ubuntu, you can install proprietary NVIDIA drivers [from the PPA](https://launchpad.net/~graphics-drivers/+archive/ubuntu/ppa) and CUDA [from the NVIDIA website](https://developer.nvidia.com/cuda-downloads). These are only required if you want to use GPU acceleration

Firstly ensure that you have a supported NVIDIA graphics card with the appropriate drivers and CUDA libraries installed.

Build the image using the following command:

```sh
./update.sh && sudo ./build
```

You will also need to install `nvidia-docker`, which we will use to start the container with GPU access. This can be found at [NVIDIA/nvidia-docker](https://github.com/NVIDIA/nvidia-docker).

#### Usage

##### Run as bash script

```sh
NV_GPU=0 nvidia-docker run --rm -it --ipc=host \
  -v "/path/to/code":/root/code:ro \
  -v "/path/to/log":/data/log \
  -v "/path/to/imagenet_path":/data/imagenet:ro \
  -v "/path/to/xray_path":/data/xrays:ro \
  -v "/path/to/other":/data/other:ro \
  -v "/path/to/annoations":/data/annotations:ro \
  -v "/path/to/pretrained_models":/models/pretrained \
  -v "/path/to/model_zoo":/models/zoo \
  --env=JUPYTER_PASSWORD="Some password in case we use jupyter" \
  --publish=8888:8888 \
  gforge/nnx-pytorch bash
```

Replace all the /path/to/... with the real paths and then. Not that in order to increase shared memory size either use --ipc=host or --shm-size options.

##### Run as notebook

```sh
NV_GPU=0 nvidia-docker run --rm -it --ipc=host \
  -v "/path/to/notebook":/root/notebook \
  ... all above
  --env=JUPYTER_PASSWORD=my_password \
  --publish=8888:8888 \
  gforge/nnx-pytorch
```
Replace `/path/to/notebook` with a directory on the host machine that you would like to store your work in.
Also add any additional volumes required for the script - e.g. the data folders

Point your web browser to [localhost:8888](http://localhost:8888) to start using the Jupyter notebook.

#### Custom configuration

You can create a `notebook.json` config file to customise the editor. Some of the options you can change are documented at https://codemirror.net/doc/manual.html#config.

Let's say that you create the following file at `/path/to/notebook.json`:

```json
{
  "CodeCell": {
    "cm_config": {
      "lineNumbers": false,
      "indentUnit": 2,
      "tabSize": 2,
      "indentWithTabs": false,
      "smartIndent": true
    }
  }
}
```

Then, when running the container, pass the following option to mount the configuration file into the container:

```sh
--volume=/path/to/notebook.json:/root/.jupyter/nbconfig/notebook.json
```

You should now notice that your notebooks are configured accordingly.
