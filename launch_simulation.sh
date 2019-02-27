#!/bin/bash

# Build Buzz
mkdir buzz/build
cd buzz/build
cmake ../src
sudo make install

# Compile Buzz script
cd ../../argos_simulation
bzzc random_trajectory.bzz

# Launch simulation
argos3 -c robust_distributed_slam.argos