[![build status](https://github.com/SacBase/sac-jupyter-notebook/workflows/docker/badge.svg)](https://github.com/SacBase/sac-jupyter-notebook/actions?query=workflow%3A"docker")
[![docker pulls](https://img.shields.io/docker/pulls/sacbase/sac-jupyter-notebook)](https://hub.docker.com/r/sacbase/sac-jupyter-notebook)

# SaC Docker

This repository contains the base Dockerfiles used for compiling and running SaC programs.

Pre-built Docker images are available on [DockerHub](https://hub.docker.com/u/sacbase).

## Try out SaC

For first time users of SaC we recommend using the Jupyter Notebook environment.

Pull the most recent image with:

```bash
docker pull sacbase/sac-jupyter-notebook
```

And start the Jupyter notebook using:

```bash
docker run -p 8888:8888 sacbase/sac-jupyter-notebook
```

When starting the container multiple URLs will be printed; use the one starting with `127.0.0.1:8888`.
