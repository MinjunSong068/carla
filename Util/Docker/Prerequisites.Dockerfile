# FROM ubuntu:18.04

# USER root

# ARG EPIC_USER=user
# ARG EPIC_PASS=pass
# ENV DEBIAN_FRONTEND=noninteractive
# RUN apt-get update ; \
#   apt-get install -y wget software-properties-common && \
#   add-apt-repository ppa:ubuntu-toolchain-r/test && \
#   wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|apt-key add - && \
#   apt-add-repository "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-8 main" && \
#   apt-get update ; \
#   apt-get install -y build-essential \
#     clang-8 \
#     lld-8 \
#     g++-7 \
#     cmake \
#     ninja-build \
#     libvulkan1 \
#     python \
#     python-pip \
#     python-dev \
#     python3-dev \
#     python3-pip \
#     libpng-dev \
#     libtiff5-dev \
#     libjpeg-dev \
#     tzdata \
#     sed \
#     curl \
#     unzip \
#     autoconf \
#     libtool \
#     rsync \
#     libxml2-dev \
#     git \
#     aria2 && \
#   pip3 install -Iv setuptools==47.3.1 && \
#   pip3 install distro && \
#   update-alternatives --install /usr/bin/clang++ clang++ /usr/lib/llvm-8/bin/clang++ 180 && \
#   update-alternatives --install /usr/bin/clang clang /usr/lib/llvm-8/bin/clang 180

# RUN useradd -m carla
# COPY --chown=carla:carla . /home/carla
# USER carla
# WORKDIR /home/carla
# ENV UE4_ROOT /home/carla/UE4.26

# RUN git clone --depth 1 -b carla "https://${EPIC_USER}:${EPIC_PASS}@github.com/CarlaUnreal/UnrealEngine.git" ${UE4_ROOT}

# RUN cd $UE4_ROOT && \
#   ./Setup.sh && \
#   ./GenerateProjectFiles.sh && \
#   make

# WORKDIR /home/carla/


FROM ubuntu:22.04

USER root

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y wget software-properties-common apt-utils wget

RUN apt-add-repository "deb http://archive.ubuntu.com/ubuntu focal main universe" 
RUN apt-get update 
RUN apt-get install -y build-essential clang-10 lld-10 g++-7 cmake ninja-build libvulkan1 python python3 python3-dev python3-pip libpng-dev libtiff5-dev libjpeg-dev tzdata sed curl unzip autoconf libtool rsync libxml2-dev git git-lfs 
RUN update-alternatives --install /usr/bin/clang++ clang++ /usr/lib/llvm-10/bin/clang++ 180 
RUN update-alternatives --install /usr/bin/clang clang /usr/lib/llvm-10/bin/clang 180 
RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 180

RUN apt-get install -y software-properties-common \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt-get install -y sudo htop tmux psmisc python3.7 python3-pip python-is-python3 git wget unzip g++ cmake tar  \
    && apt-get install -y libpng16-16 libjpeg-turbo8 libtiff5 libomp5 \
    && apt-get install -y libice6 libsm6 libxaw7 libxkbfile1 libxmu6 libxpm4 libxt6 x11-common x11-xkb-utils xkb-data \
    && apt-get install -y nano

ARG GHP_KEY

RUN useradd -m carla
COPY --chown=carla:carla . /home/carla
USER carla
WORKDIR /home/carla
ENV UE4_ROOT=/home/carla/UE4.26

# RUN git clone --depth 1 -b carla "https://${GHP_KEY}@github.com/CarlaUnreal/UnrealEngine.git" ${UE4_ROOT}

RUN cd $UE4_ROOT && \
  ./Setup.sh && \
  ./GenerateProjectFiles.sh && \
  make

WORKDIR /home/carla/