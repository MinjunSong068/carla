# FROM carla-prerequisites:latest

# ARG GIT_BRANCH

# USER carla
# WORKDIR /home/carla

# RUN cd /home/carla/ && \
#   if [ -z ${GIT_BRANCH+x} ]; then git clone --depth 1 https://github.com/carla-simulator/carla.git; \
#   else git clone --depth 1 --branch $GIT_BRANCH https://github.com/carla-simulator/carla.git; fi && \
#   cd /home/carla/carla && \
#   ./Update.sh && \
#   make CarlaUE4Editor && \
#   make PythonAPI && \
#   make build.utils && \
#   make package && \
#   rm -r /home/carla/carla/Dist

# WORKDIR /home/carla/carla

 
FROM carla-prerequisites:latest

ARG GIT_BRANCH=messages

USER carla
WORKDIR /home/carla

# RUN cd /home/carla/ && \
#   if [ -z ${GIT_BRANCH+x} ]; then git clone --depth 1 https://github.com/carla-simulator/carla.git; \
#   else git clone --depth 1 --branch $GIT_BRANCH https://github.com/carla-simulator/carla.git; fi

RUN cd /home/carla/ && \
  git clone --depth 1 --branch messages https://github.com/MinjunSong068/carla.git


# RUN cd /home/carla/ && \
#   git clone --depth 1 --branch ue4-dev https://github.com/MinjunSong068/carla.git

RUN cd /home/carla/carla && \
  ./Update.sh

RUN pip3 install -Iv setuptools==47.3.1 && \
   pip3 install distro

# RUN UE4_ROOT /home/carla/UE4.26

RUN cd /home/carla/carla && \
  make CarlaUE4Editor

ENV UE4_ROOT=/home/carla/UE4.26

RUN cd /home/carla/carla && \
  make PythonAPI

RUN cd /home/carla/carla && \
  make build.utils

# RUN cd /home/carla/carla && \
#   make package && \
#   rm -r /home/carla/carla/Dist

RUN cd /home/carla/carla && \
  make package

WORKDIR /home/carla/carla

USER root

# RUN apt-get install -y xorg-dev

RUN packages='libsdl2-2.0 xserver-xorg libvulkan1 libomp5 xdg-user-dirs xdg-utils xorg-dev'  \
    && apt-get update  \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y $packages --no-install-recommends

USER carla
WORKDIR /home/carla/carla
