## Simulation
- Fix licenses

## buzz_slam
- Create readme
- Add multiple parameters to be specified in buzz (sigmas, sensor ranges)
- Fix licenses
- Move code into the distibuted optimizer repo. Refactor names, adding centralized and decentralized
- Specify what needd to be done into buzz_controller_quadmapper
- Find a clean way to share images between robots (maybe share message with the ROS channel to listen to).

## Distributed optimizer
- Implement and decentralize flagged initialization.
- Decentralize optimization
- Update factor in graph after optimization
- Update Readme
- Generate documentation
- Update dockerfile
- Create files for find package
- Code and incremental version of distributed_mapper::loadSubgraphAndCreateSubgraphEdge
- Fix licenses
- Add flagged initialization
- Add a control barrier at the end of the optimization before restart movements

## Docker
- Find how to use the xserver without using the `--privileged` option. 