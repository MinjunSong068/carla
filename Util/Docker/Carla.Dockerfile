# FROM carla-prerequisites:latest

FROM carla-preq:Minjun

ARG GIT_BRANCH

USER carla
WORKDIR /home/carla


RUN cd /home/carla/carla && \
  ./Update.sh

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
