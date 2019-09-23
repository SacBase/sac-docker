SaC Compiler Docker Image
=========================

[![Build Status](https://api.cirrus-ci.com/github/SacBase/sac-docker.svg)](https://cirrus-ci.com/github/SacBase/sac-docker)

This repository provides a Dockerfile to create a docker container
that includes the SaC Compiler (`sac2c`, `sac4c`, etc.).

This container is mainly used for running CI for other projects within
the [SaCBase](//github.com/SacBase) organisation. It can be used though
for testing out the compiler.

_Be aware that only the compiler is included, not the standard library._

ToDo
----

 * Provide dockerfiles for different distros
 * Automatic alignment with SaC upstream (no manual updating)
 * Provide dockerfile with standard library included as well
