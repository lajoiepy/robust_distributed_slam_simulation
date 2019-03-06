#!/bin/bash

# Build Buzz
mkdir buzz/build
cd buzz/build
cmake ../src
sudo make install
cd ../..

# Build Robust Distributed Mapper
cd robust_distributed_mapper/cpp
mkdir build
cd build
cmake ..
make
sudo make install
cd ../../..

# Compile Buzz script
cd argos_simulation
bzzc random_walk_mapping.bzz

# Launch simulation
argos3 -c robust_distributed_slam.argos