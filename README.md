# Tensorflow-GPU with Singularity
<b>Note:</b> After the release of Singularity-2.3, it is no longer necessary to install NVIDIA drivers into your Singularity container to access the GPU on a host node. Please visit [HPC Singularity Guide](https://sites.google.com/a/case.edu/hpc-upgraded-cluster/home/Software-Guide/singularity)
# Table of Contents
1. [Tensorflow Installation](#Tensorflow)
2. [Testing](#Testing)
3. [Tenosorflow-gpu with Python3[(#Tenosorflow-gpu with Python3) 
4. [Troubleshooting](#Troubleshooting)

## Tensorflow installation
### Pre-requisites: 
Make sure all these files/directories are in the same directory, say tensorflow-gpu [1].
```
build_container_cuda7.5.sh  cuda-7.5               cudnn-7.5-linux-x64-v5.1.tgz  links.sh                        
cuda                     cuda_7.5.18_linux.run  install_cuda.sh               NVIDIA-Linux-x86_64-375.26.run
```
Here, cuda-7.5 is the cuda installation directory created after the installation using cuda_7.5.18_linux.run. cuda directory contains cudnn libraries which are obtained after untarring cudnn-7.5-linux-x64-v5.1.tgz. You need to register in NVIDIA to download cudnn. You need to match the driver and cuda version appropriately if you are installing other version of cuda. So, modify the scripts accordingly.

Check the driver version of the node:
```
nvidia-smi
```

### Installation
Go to the tensorflow-gpu directory and run the script - build_container_cuda7.5.sh
```
sh build_container_cuda7.5.sh
```
You will find the image tensorflow.img created in the same directory, tensorflow-gpu

## Testing
Follow the [HPC Singularity Guide](https://sites.google.com/a/case.edu/hpc-upgraded-cluster/home/Software-Guide/singularity)

## Tenosorflow-gpu with Python3
In the imported tensorflow docker image, python3 may already be installed. You need to install pip3. To avoid the error "E: Failed to fetch", you need to update the packages 
```
sudo /usr/local/singularity/2.2.1/bin/singularity exec --writable $TENSORFLOW apt-get update
```
### Install Pip
```
sudo /usr/local/singularity/2.2.1/bin/singularity exec --writable $TENSORFLOW apt-get install python3-pip
```
If you get the error "perl: warning: Setting locale failed", you need to install the package "language-pack-en-base", re-install "python3-pip"
```
sudo /usr/local/singularity/2.2.1/bin/singularity exec --writable $TENSORFLOW apt-get install language-pack-en-base
sudo /usr/local/singularity/2.2.1/bin/singularity exec --writable $TENSORFLOW apt-get purge python3-pip
sudo /usr/local/singularity/2.2.1/bin/singularity exec --writable $TENSORFLOW apt-get install python3-pip
```
### Test Pip3
```
singularity exec $TENSORFLOW pip3 show pip
```
### Install tensorflow-gpu module
check the tensorflow module version installed with python2
```
singularity exec $TENSORFLOW python -c 'import tensorflow as tf; print(tf.__version__)'
```
Install the same version (e.g. 1.1.0-rc2) of tensorflow
```
sudo /usr/local/singularity/2.2.1/bin/singularity exec --writable $TENSORFLOW python3 -m pip install tensorflow-gpu==1.1.0-rc2
```
## Install Keras (optional)
```
sudo /usr/local/singularity/2.2.1/bin/singularity exec --writable $TENSORFLOW python3 -m pip install keras
```

## Troubleshooting

<b>Issue</b>: CUDA_UNKNOWN_ERROR
---------
2017-04-20 20:51:13.381572: E tensorflow/stream_executor/cuda/cuda_driver.cc:405] failed call to cuInit: CUDA_ERROR_UNKNOWN
2017-04-20 20:51:13.381599: I tensorflow/stream_executor/cuda/cuda_diagnostics.cc:158] retrieving CUDA diagnostic information for host: gpu029t

--------

<b> Solution</b>: Run the following:
```
/sbin/MAKEDEV nvidia
chmod 666 /dev/nvidia*
/usr/bin/nvidia-smi -pm 1
/usr/bin/nvidia-smi -c 3
nvidia-modprobe
nvidia-cuda-mps-server    # if necessary
```
<b>Issue</b>: The minimum required Cuda capability is 3.0. Device mapping: no known devices

<b>Solution</b>: check the version of Cuda compute capability (CC) - check [HPC Guide to Cuda] (https://sites.google.com/a/case.edu/hpc-upgraded-cluster/home/Software-Guide/cuda).
```
module load cuda
deviceQuery
```

## References
1. [Singularity-Images](https://github.com/clemsonciti/singularity-images/tree/master/tensorflow)
2. [Singularity-Docker](http://singularity.lbl.gov/docs-docker)
3. [HPC Singularity Guide](https://sites.google.com/a/case.edu/hpc-upgraded-cluster/home/Software-Guide/singularity)
