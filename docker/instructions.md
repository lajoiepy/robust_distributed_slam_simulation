# Install dependencies
https://github.com/mviereck/x11docker
# First build
docker build . --tag rdpgo --network host
# To start
sudo x11docker --hostdisplay --hostnet -- --privileged --name rdpgo-robot1 -- rdpgo:latest
# To attach into it
docker exec -it rdpgo-robot1 /bin/bash

# Rebuild with updated code
docker build . --tag rdpgo --network host --build-arg CODE_UPDATE=<dummy-arg>