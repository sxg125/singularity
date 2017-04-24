# Singularity Guide

## Tensorflow installation
### Pre-requisites: 
Make sure all these files/directories are in the same directory, say tensorflow-gpu [1].
```
build_container_cuda7.5.sh  cuda-7.5               cudnn-7.5-linux-x64-v5.1.tgz  links.sh                        
cuda                     cuda_7.5.18_linux.run  install_cuda.sh               NVIDIA-Linux-x86_64-375.26.run
```
Here, cuda-7.5 is the cuda installation directory created after the installation using cuda_7.5.18_linux.run. cuda directory contains cudnn libraries which are obtained after untarring cudnn-7.5-linux-x64-v5.1.tgz. You need to register in NVIDIA to download cudnn.
### Installation
Go to the tensorflow-gpu directory and run the script - build_container_cuda7.5.sh
```
sh build_container_cuda7.5.sh
```
You will find the image tensorflow.img created in the same directory, tensorflow-gpu
### Testing
Follow the [HPC Singularity Guide] (https://sites.google.com/a/case.edu/hpc-upgraded-cluster/home/Software-Guide/singularity)
[VTK/Python] (http://www.vtk.org/Wiki/VTK/Examples/Python/Graphs/NOVCAGraph)

## References
1. [Singularity-Images] (https://github.com/clemsonciti/singularity-images/tree/master/tensorflow)
2. [Singularity-Docker] (http://singularity.lbl.gov/docs-docker)
3. [HPC Singularity Guide] (https://sites.google.com/a/case.edu/hpc-upgraded-cluster/home/Software-Guide/singularity)
