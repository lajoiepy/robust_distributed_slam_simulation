## Simulation
- Increase max message size
- Encapsulate in docker
- Fix licenses
- Slow down the simulation. Move every N step, rest for communication.

## buzz_slam
- Create readme
- Streamline build and installation
- Encapsulate in docker
- Add multiple parameters to be specified in buzz (sigmas, sensor ranges)
- Fix licenses
- Move code into the distibuted optimizer repo. Refactor names, adding centralized and decentralized
- Specify what needd to be done into buzz_controller_quadmapper
- Find a clean way to share images between robots (maybe share message with the ROS channel to listen to).

## Distributed optimizer
- Decentralize flagged initialization.
- Decentralize optimization
- Update Readme
- Generate documentation
- Update dockerfile
- Create files for find package
- Code and incremental version of distributed_mapper::loadSubgraphAndCreateSubgraphEdge
- Fix licenses
- Add flagged initialization

## Docker
- Find how to use the xserver without using the `--privileged` option. 