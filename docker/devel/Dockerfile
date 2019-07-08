FROM ubuntu:18.04
LABEL Maintainer="Pierre-Yves Lajoie <lajoie.py@gmail.com>"
LABEL robust-multi-robot-slam-simulation.version="0.1"

# Install common dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    dpkg \ 
    git \
    pkg-config \
    python \
    python-dev \
    python-numpy \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Install GTSAM
RUN apt-get update && apt-get install -y \
    libboost-all-dev \
    cmake \
    libtbb-dev \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://bitbucket.org/gtborg/gtsam && \
    cd gtsam && \
    git checkout develop && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j2 && \
    make install

# Install Eigen3 (packaged in GTSAM)
RUN cd gtsam/gtsam/3rdparty/Eigen && \
    mkdir build && \
    cd build && \
    cmake .. &&\
    make install

# Install ARGoS
RUN apt-get update && apt-get install -y \
    wget \
    freeglut3-dev \
    qt5-default \
    libxi-dev \
    libxmu-dev \
    libfreeimage-dev \
    libfreeimageplus-dev \
    liblua5.2-dev \
    lua5.2 \
    && rm -rf /var/lib/apt/lists/*

RUN wget -O argos3-package.deb https://drive.google.com/uc\?authuser\=0\&id\=1VGDogC8tBipOv2kykJH4hsckXoBRKmFa\&export\=download

RUN apt-get update && \
    apt-get -y install sudo
RUN adduser --disabled-password --gecos '' docker
RUN adduser docker sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER docker
RUN sudo dpkg -i argos3-package.deb
RUN sudo chmod -R ugo+rw /home/docker
USER root

# Install Buzz
RUN git clone https://github.com/MISTLab/Buzz.git /home/docker/buzz
RUN cd /home/docker/buzz &&\
    mkdir build &&\
    cd build &&\
    cmake -DCMAKE_BUILD_TYPE=Debug ../src &&\
    make &&\
    make install &&\
    ldconfig

# Install and setup some editing and debugging tools
RUN sudo apt-get install -y gedit nano strace valgrind

RUN sudo wget -O vscode.deb https://go.microsoft.com/fwlink/?LinkID=760868 &&\
    sudo apt install -y ./vscode.deb &&\
    sudo apt install -y libasound2

RUN mkdir /home/docker/code &&\
    code --install-extension ms-vscode.cpptools --user-data-dir /home/docker/code

# Settings for buzz editing
RUN touch /home/docker/code/User/settings.json &&\
    echo "{ \"files.associations\": { \"*.bzz\":\"python\" } }" > /home/docker/code/User/settings.json

# Add dummy argument to force rebuild starting from that point
ARG CODE_UPDATE=unknown

# Clone simulation
RUN git clone https://github.com/lajoiepy/robust_distributed_slam_simulation.git /home/docker/robust_distributed_slam_simulation &&\
    cd /home/docker/robust_distributed_slam_simulation &&\
    git submodule update --init --recursive

# Install Robust Distributed Mapper
RUN cd /home/docker/robust_distributed_slam_simulation/buzz_slam/robust_distributed_mapper/cpp &&\
    mkdir build &&\
    cd build &&\
    cmake -DCMAKE_BUILD_TYPE=Debug ../ &&\
    make &&\
    make install

# Install Buzz SLAM
RUN cd /home/docker/robust_distributed_slam_simulation/buzz_slam &&\
    mkdir build &&\
    cd build &&\
    cmake -DCMAKE_BUILD_TYPE=Debug ../src &&\
    make &&\
    make install

# Compile buzz script
RUN cd /home/docker/robust_distributed_slam_simulation/argos_simulation &&\
    bzzc random_walk_mapping.bzz &&\
    bzzc dataset_mapping.bzz

# Setup debug config for visual studio code
RUN mkdir /home/docker/robust_distributed_slam_simulation/.vscode && touch /home/docker/robust_distributed_slam_simulation/.vscode/launch.json &&\
    echo "{\"version\": \"0.2.0\",\"configurations\": [{\"name\": \"(gdb) Attach\", \"type\": \"cppdbg\", \"request\": \"attach\", \"program\" : \"/usr/bin/argos3\", \"processId\": \"\${command:pickProcess}\", \"MIMode\": \"gdb\", \"setupCommands\": [ {\"description\": \"Enable pretty-printing for gdb\", \"text\": \"-enable-pretty-printing\",\"ignoreFailures\": true}]}]}" \
    > /home/docker/robust_distributed_slam_simulation/.vscode/launch.json

# Put your own git credentials to commit edited code
RUN git config --global user.email "lajoie.py@gmail.com" &&\
    git config --global user.name "Pierre-Yves Lajoie"

# Entry point to start the simulation
WORKDIR /home/docker/robust_distributed_slam_simulation/argos_simulation
# ENTRYPOINT argos3 -c robust_distributed_slam.argos