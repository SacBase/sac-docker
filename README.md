# SaC Jupyter Notebook

[![build status](https://github.com/SacBase/sac-jupyter-notebook/workflows/docker/badge.svg)](https://github.com/SacBase/sac-jupyter-notebook/actions?query=workflow%3A"docker")
[![Docker Pulls](https://img.shields.io/docker/pulls/sacbase/sac-jupyter-notebook)](https://hub.docker.com/r/sacbase/sac-jupyter-notebook)

This repository contains the base Dockerfile used for constructing a Jupyter Notebook image with the [SaC Jupyter kernel](https://github.com/SacBase/sac-jupyter) included.

Pre-built Docker images are available on [DockerHub](https://hub.docker.com/r/sacbase/sac-jupyter-notebook).

```
docker run -p 8888:8888 sacbase/sac-jupyter-notebook
```
