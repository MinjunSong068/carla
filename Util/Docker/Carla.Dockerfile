FROM carla-prerequisites:latest

ARG GIT_BRANCH

USER carla
WORKDIR /home/carla

RUN cd /home/carla/ && \
  if [ -z ${GIT_BRANCH+x} ]; then git clone --depth 1 https://github.com/carla-simulator/carla.git; \
  else git clone --depth 1 --branch $GIT_BRANCH https://github.com/carla-simulator/carla.git; fi && \
  cd /home/carla/carla && \
  ./Update.sh 

RUN cd /home/carla/carla && \
  make CarlaUE4Editor 

RUN cd /home/carla/carla && \
  make PythonAPI 

RUN cd /home/carla/carla && \
  make build.utils

RUN cd /home/carla/carla && \
  make package

WORKDIR /home/carla/carla
