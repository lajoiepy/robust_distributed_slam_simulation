# Install dependencies

https://github.com/mviereck/x11docker

# First build
docker build . --tag rdpgo --network host
# To start
sudo x11docker --hostdisplay --hostnet --user=RETAIN -- --privileged -v <log-folder-on-host-computer>:/home/docker/robust_distributed_slam_simulation/argos_simulation/log -- rdpgo:latest
# To get a bash shell into the container
docker exec -w /home/docker/robust_distributed_slam_simulation/argos_simulation -it <container-name> /bin/bash

# Rebuild with updated code
docker build . --tag rdpgo --network host --build-arg CODE_UPDATE=<dummy-arg>