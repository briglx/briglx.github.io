---
title: "Checking out TSLearn"
date: "2018-03-29"
---

I'm toying around with my new dashcam videos and thought I would try to build a neural network. I found [Adam Geitgey's article](https://medium.com/@ageitgey/machine-learning-is-fun-part-3-deep-learning-and-convolutional-neural-networks-f40359318721) really interesting.

**My setup**

- Surface Book
- Graphics Card GeForce 900M Series (Notebooks)
    - GeForce 940M (1 GB)
    - 5.0 Compute Capability
- Windows 10 x86\_64
- Python 2.7.14 Anaconda 5.1
- CUDA 9.0
- cuDNN v7.1.2 (Mar 21, 2018), for CUDA 9.0

TFLearn requires TensorFlow

**Installing TensorFlow - Prerequisites**

- CUDA® Toolkit 9.0.
    - Base Installer cuda\_9.0.176\_win10\_network.exe
    - Patch 1 (Released Jan 25, 2018)
    - Patch 3 (Released Mar 5, 2018)
- cuDNN v7.0
- TensorFlow
- Python 3

Step

## Install Cudo Driver

Check for valid installation

```
$> nvcc --version

nvcc: NVIDIA (R) Cuda compiler driver
Copyright (c) 2005-2017 NVIDIA Corporation
Built on Fri_Sep__1_21:08:32_Central_Daylight_Time_2017
Cuda compilation tools, release 9.0, V9.0.176
```

Build Projects and run device query

```
$> deviceQuery

deviceQuery Starting...

 CUDA Device Query (Runtime API) version (CUDART static linking)

Detected 1 CUDA Capable device(s)

Device 0: "GeForce GPU"
  CUDA Driver Version / Runtime Version          9.0 / 9.0
  CUDA Capability Major/Minor version number:    5.0
  Total amount of global memory:                 1024 MBytes (1073741824 bytes)
  ( 3) Multiprocessors, (128) CUDA Cores/MP:     384 CUDA Cores
  GPU Max Clock rate:                            993 MHz (0.99 GHz)
  Memory Clock rate:                             2505 Mhz
  Memory Bus Width:                              64-bit
  L2 Cache Size:                                 1048576 bytes
  Maximum Texture Dimension Size (x,y,z)         1D=(65536), 2D=(65536, 65536), 3D=(4096, 4096, 4096)
  Maximum Layered 1D Texture Size, (num) layers  1D=(16384), 2048 layers
  Maximum Layered 2D Texture Size, (num) layers  2D=(16384, 16384), 2048 layers
  Total amount of constant memory:               65536 bytes
  Total amount of shared memory per block:       49152 bytes
  Total number of registers available per block: 65536
  Warp size:                                     32
  Maximum number of threads per multiprocessor:  2048
  Maximum number of threads per block:           1024
  Max dimension size of a thread block (x,y,z): (1024, 1024, 64)
  Max dimension size of a grid size    (x,y,z): (2147483647, 65535, 65535)
  Maximum memory pitch:                          2147483647 bytes
  Texture alignment:                             512 bytes
  Concurrent copy and kernel execution:          Yes with 1 copy engine(s)
  Run time limit on kernels:                     Yes
  Integrated GPU sharing Host Memory:            No
  Support host page-locked memory mapping:       Yes
  Alignment requirement for Surfaces:            Yes
  Device has ECC support:                        Disabled
  CUDA Device Driver Mode (TCC or WDDM):         WDDM (Windows Display Driver Model)
  Device supports Unified Addressing (UVA):      Yes
  Supports Cooperative Kernel Launch:            No
  Supports MultiDevice Co-op Kernel Launch:      No
  Device PCI Domain ID / Bus ID / location ID:   0 / 1 / 0
  Compute Mode:
     < Default (multiple host threads can use ::cudaSetDevice() with device simultaneously) >

deviceQuery, CUDA Driver = CUDART, CUDA Driver Version = 9.0, CUDA Runtime Version = 9.0, NumDevs = 1
Result = PASS

```

## Install cuDNN

Installed Download cuDNN v7.1.2 (Mar 21, 2018), for CUDA 9.0

Copied files from zip to

\\cuda\\bin\\cudnn64\_7.dll to C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v9.1\\bin. \\cuda\\ include\\cudnn.h to C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v9.1\\include. \\cuda\\lib\\x64\\cudnn.lib to C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v9.1\\lib\\x64.

## Install Python 3

Tensor Flow requires python three. Use conda to create a new environment

```
$> conda create -n py36 python=3.6 anaconda

# To activate this environment, use:
# > activate py36
#
# To deactivate an active environment, use:
# > deactivate

$> activate py36

$> conda install pip
```

## Install TSLearn

pip install tflearn

## Errors

Must use CUDA 9.0 NOT 9.1

> ImportError: Could not find 'cudart64\_90.dll'. TensorFlow requires that this DLL be installed in a directory that is named in your %PATH% environment variable. Download and install CUDA 9.0 from this URL: [https://developer.nvidia.com/cuda-toolkit](https://developer.nvidia.com/cuda-toolkit)

## **References**

- https://www.tensorflow.org/install/install\_windows
- Cudu Installation [http://docs.nvidia.com/cuda/cuda-installation-guide-microsoft-windows/](http://docs.nvidia.com/cuda/cuda-installation-guide-microsoft-windows/)
- Cudo Developer Toolkit [https://developer.nvidia.com/cuda-downloads?target\_os=Windows&target\_arch=x86\_64&target\_version=10&target\_type=exenetwork](https://developer.nvidia.com/cuda-downloads?target_os=Windows&target_arch=x86_64&target_version=10&target_type=exenetwork)
- cuDNN installation [http://docs.nvidia.com/deeplearning/sdk/cudnn-install/index.html#install-windowshttps://developer.nvidia.com/cudnn](http://docs.nvidia.com/deeplearning/sdk/cudnn-install/index.html#install-windows)
