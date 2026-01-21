FROM carla-prerequisites:latest

ARG GIT_BRANCH

USER carla
WORKDIR /home/carla


RUN cd /home/carla/carla && \
  git clone https://bitbucket.org/carla-simulator/carla-content Unreal/CarlaUE4/Content/Carla

RUN make launch

# RUN cd /home/carla/carla && \
#   make CarlaUE4Editor 

# RUN cd /home/carla/carla && \
#   make PythonAPI 

RUN cd /home/carla/carla && \
  make build.utils

RUN cd /home/carla/carla && \
  make package

WORKDIR /home/carla/carla
