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
    make -j8 && \
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

# Install Buzz
RUN git clone https://github.com/MISTLab/Buzz.git /home/docker/buzz
RUN cd /home/docker/buzz &&\
    mkdir build &&\
    cd build &&\
    cmake ../src &&\
    make &&\
    sudo make install &&\
    sudo ldconfig

# Add dummy argument to force rebuild starting from that point
ARG CODE_UPDATE=unknown

# Clone simulation
RUN git clone https://github.com/lajoiepy/robust_distributed_slam_simulation.git /home/docker/robust_distributed_slam_simulation &&\
    cd /home/docker/robust_distributed_slam_simulation &&\
    git checkout decentralization &&\
    git submodule update --init --recursive

# Install some editing tools
RUN sudo apt-get install -y gedit nano

# Install Robust Distributed Mapper
RUN cd /home/docker/robust_distributed_slam_simulation/buzz_slam/robust_distributed_mapper/cpp &&\
    mkdir build &&\
    cd build &&\
    sudo ln -sf eigen3/Eigen Eigen &&\
    cmake ../ 
    #&&\
    #make &&\
    #sudo make install

# Install Buzz SLAM
#RUN cd /home/docker/robust_distributed_slam_simulation/buzz_slam &&\
#    mkdir build &&\
#    cd build &&\
#    cmake ../src &&\
#    make &&\
#    sudo make install