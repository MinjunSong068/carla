# FROM carla-prerequisites:latest

FROM carla-preq:Minjun

ARG GIT_BRANCH

USER carla
WORKDIR /home/carla

RUN cd /home/carla/ && \
  cd /home/carla/carla

RUN cd /home/carla/carla && \
  ./Update.sh

USER root

RUN apt-get update ; \
  apt-get install -y wget software-properties-common && \
  add-apt-repository ppa:ubuntu-toolchain-r/test && \
  wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|apt-key add - && \
  apt-add-repository "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-8 main" && \
  apt-get update ; \
  apt-get install -y build-essential \
    clang-8 \
    lld-8 \
    g++-7 \
    cmake \
    ninja-build \
    libvulkan1 \
    python \
    python-pip \
    python-dev \
    python3-dev \
    python3-pip \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    tzdata \
    sed \
    curl \
    unzip \
    autoconf \
    libtool \
    rsync \
    libxml2-dev \
    git \
    aria2 && \
  pip3 install -Iv setuptools==47.3.1 && \
  pip3 install distro && \
  update-alternatives --install /usr/bin/clang++ clang++ /usr/lib/llvm-8/bin/clang++ 180 && \
  update-alternatives --install /usr/bin/clang clang /usr/lib/llvm-8/bin/clang 180

USER carla
WORKDIR /home/carla

RUN cd /home/carla/carla && \
  export UE4_ROOT=/home/carla/UE4.26 && \
  make CarlaUE4Editor 

RUN cd /home/carla/carla && \
  export UE4_ROOT=/home/carla/UE4.26 && \
  make PythonAPI 
# RUN cd /home/carla/carla && \
#   make launch

RUN cd /home/carla/carla && \
  export UE4_ROOT=/home/carla/UE4.26 && \
  make build.utils

RUN cd /home/carla/carla && \
  export UE4_ROOT=/home/carla/UE4.26 && \
  make package
WORKDIR /home/carla/carla

USER root

RUN apt-get update ; \
  apt-get install -y sudo fontconfig gdb

RUN usermod -aG sudo carla \
    && echo "carla:carla" | chpasswd

COPY --chown=carla:carla . /home/carla
USER carla

RUN pip3 install pygame-ce numpy