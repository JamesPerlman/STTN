# syntax=docker/dockerfile:1

FROM continuumio/miniconda3:4.10.3p0-alpine AS miniconda

FROM nvidia/cuda:10.1-cudnn8-devel-ubuntu18.04 AS main

# Set up CUDA build machine
ENV DEBIAN_FRONTEND noninteractive
ENV HOME_PATH=/home
ENV PROJ_PATH=${HOME_PATH}/STTN

# We just need conda from the alpine miniconda build

COPY --from=miniconda /opt/conda /opt/conda

RUN echo "export PATH=\${PATH}:/opt/conda/bin" >> ~/.bashrc
ENV PATH=${PATH}:/opt/conda/bin

# Install apt dependencies first

RUN apt-get update && \
    apt-get install -y \
        ffmpeg \
        git \
        libsm6 \
        libxext6 \
        rsync \
        wget

# Create conda env

COPY environment.yml .

RUN conda env create -f environment.yml && \
    echo "source activate sttn" >> ~/.bashrc

SHELL ["conda", "run", "-n", "sttn", "/bin/bash", "-c"]

RUN pip install https://download.pytorch.org/whl/cu101/torch-1.3.0-cp36-cp36m-manylinux1_x86_64.whl && \
    pip install https://download.pytorch.org/whl/cu101/torchvision-0.4.1-cp36-cp36m-linux_x86_64.whl

# Clone github repo

RUN git clone https://github.com/JamesPerlman/STTN.git ${PROJ_PATH} && \
    echo Cache busting... cloning commit 2ba8eb1

WORKDIR ${PROJ_PATH}

# Download pretrained models

RUN pip install gdown

RUN mkdir checkpoints

RUN gdown "https://drive.google.com/u/0/uc?id=1ZAMV8547wmZylKRt5qR_tC5VlosXD4Wv&export=download" -O checkpoints/sttn.pth
