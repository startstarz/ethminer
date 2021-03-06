#!/bin/sh
#
# Install the core CUDA_VER toolkit for Ubuntu 16.04.
# Requires the CUDA_VER environment variable to be set to the required version.
#
# Since this script updates environment variables, to execute correctly you must
# 'source' this script, rather than executing it in a sub-process.
#
# Taken from https://github.com/tmcdonell/travis-scripts.

set -e

CUDA_VER=9.1.85-1
if [ "$1" != "" ]; then
  CUDA_VER=$1
fi
if [ "$CUDA_VER" = "8" ]; then
  CUDA_VER=8.0.61-1
  CUDA_PACKAGE=cuda-core
elif [ "$CUDA_VER" = "9" ]; then
  CUDA_VER=9.1.85-1
elif [ "$CUDA_VER" = "9.1" ]; then
  CUDA_VER=9.1.85-1
elif [ "$CUDA_VER" = "9.2" ]; then
  CUDA_VER=9.2.148-1
elif [ "$CUDA_VER" = "10" ]; then
  CUDA_VER=10.0.130-1
fi

if [ -z $CUDA_PACKAGE ]; then
  CUDA_PACKAGE=cuda-nvcc
fi

# from: https://developer.nvidia.com/cuda-toolkit-ARCHIVE

# wget http://developer.download.nvidia.com/compute/cuda/repos/rhel7/x86_64/cuda-repo-rhel7-8.0.61-1.x86_64.rpm
#wget https://developer.download.nvidia.com/compute/cuda/11.1.0/local_installers/cuda-repo-rhel7-11-1-local-11.1.0_455.23.05-1.x86_64.rpm
#sudo rpm -i cuda-repo-rhel7-11-1-local-11.1.0_455.23.05-1.x86_64.rpm
#wget http://developer.download.nvidia.com/compute/cuda/repos/rhel7/x86_64/cuda-repo-rhel7-${CUDA_VER}.x86_64.rpm
#sudo rpm -i cuda-repo-rhel7-${CUDA_VER}.x86_64.rpm
#sudo yum clean all
#sudo yum -y install nvidia-driver-latest-dkms cuda
#sudo yum -y install cuda-drivers

#wget https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda_9.0.176_384.81_linux-run
#sudo sh cuda_9.0.176_384.81_linux-run --override --toolkit --silent

wget https://developer.download.nvidia.com/compute/cuda/10.1/Prod/local_installers/cuda-repo-rhel7-10-1-local-10.1.243-418.87.00-1.0-1.x86_64.rpm
sudo rpm -i cuda-repo-rhel7-10-1-local-10.1.243-418.87.00-1.0-1.x86_64.rpm
sudo yum clean all
sudo yum -y install cuda-10-1

sudo yum -y install mesa-libGL-devel

#sudo apt-get install -qy $CUDA_PACKAGE-$CUDA_APT cuda-cudart-dev-$CUDA_APT
#sudo apt-get clean

#CUDA_APT=$(echo $CUDA_VER | sed 's/\.[0-9]\+\-[0-9]\+$//;s/\./-/')
#CUDA_APT=$(echo $CUDA_APT | sed 's/-/./')
export CUDA_HOME=/usr/local/cuda
export PATH=${CUDA_HOME}/bin:${PATH}
export PATH=/usr/local/cuda/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-$CUDA_APT/lib64:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:${LD_LIBRARY_PATH}
