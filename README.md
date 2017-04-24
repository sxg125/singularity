# Table of Contents
1. [Tensorflow Installation](#Tensorflow)
2. [Testing](#Testing)
3. [Troubleshooting](#Troubleshooting)

# Singularity Guide

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
Follow the [HPC Singularity Guide] (https://sites.google.com/a/case.edu/hpc-upgraded-cluster/home/Software-Guide/singularity)

## Troubleshooting
<b>Issue</b>: CUDA_ERROR_UNKNOWN
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
1. [Singularity-Images] (https://github.com/clemsonciti/singularity-images/tree/master/tensorflow)
2. [Singularity-Docker] (http://singularity.lbl.gov/docs-docker)
3. [HPC Singularity Guide]  (https://sites.google.com/a/case.edu/hpc-upgraded-cluster/home/Software-Guide/singularity)
