#Created by Sanjaya Gajurel -
#References:
#1. https://github.com/clemsonciti/singularity-images/tree/master/tensorflow
#2. http://singularity.lbl.gov/docs-docker

# Remove the image first
#sudo rm -f ubuntu_tensorflow_gpu.img

#Create tensorflow image
sudo /usr/local/singularity/2.2.1/bin/singularity create tensorflow.img
sudo /usr/local/singularity/2.2.1/bin/singularity expand --size 8192 tensorflow.img

# Import tensorflow image from docker
#sudo /usr/local/singularity/2.2.1/bin/singularity bootstrap tensorflow.img ubuntu.def
sudo /usr/local/singularity/2.2.1/bin/singularity import tensorflow.img docker://tensorflow/tensorflow:latest
sudo /usr/local/singularity/2.2.1/bin/singularity import tensorflow.img docker://tensorflow/tensorflow:latest-gpu

# Install and run CUDA driver
sudo /usr/local/singularity/2.2.1/bin/singularity exec -B `pwd`:/mnt -w tensorflow.img sh /mnt/install_cuda.sh
#sudo /usr/local/singularity/2.2.1/bin/singularity exec -B `pwd`:/mnt -w tensorflow.img sh /mnt/install_tensorflow.sh

# Create mount points
sudo /usr/local/singularity/2.2.1/bin/singularity exec -B `pwd`:/mnt -w tensorflow.img mkdir /local_scratch
sudo /usr/local/singularity/2.2.1/bin/singularity exec -B `pwd`:/mnt -w tensorflow.img mkdir /scratch
sudo /usr/local/singularity/2.2.1/bin/singularity exec -B `pwd`:/mnt -w tensorflow.img mkdir /software

# Install Keras
sudo /usr/local/singularity/2.2.1/bin/singularity exec --writable tensorflow.img pip install keras
