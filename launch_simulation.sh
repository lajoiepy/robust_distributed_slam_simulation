#!/bin/bash

# Build Buzz SLAM
mkdir buzz_slam/build
cd buzz_slam/build
cmake ../src
sudo make install
cd ../..

# Build Robust Distributed Mapper
cd buzz_slam/robust_distributed_mapper/cpp
mkdir build
cd build
cmake ..
make
sudo make install
cd ../../../..

# Compile Buzz script
cd argos_simulation
bzzc random_walk_mapping_no_sensing.bzz

# Launch simulation
argos3 -c robust_distributed_slam.argos