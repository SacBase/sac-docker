[![build status](https://github.com/SacBase/sac-jupyter-notebook/workflows/docker/badge.svg)](https://github.com/SacBase/sac-jupyter-notebook/actions?query=workflow%3A"docker")
[![docker pulls](https://img.shields.io/docker/pulls/sacbase/sac-jupyter-notebook)](https://hub.docker.com/r/sacbase/sac-jupyter-notebook)

# SaC Docker

This repository contains the base Dockerfiles used for compiling and running SaC programs.

Pre-built Docker images are available on [DockerHub](https://hub.docker.com/u/sacbase).

## Try out SaC interactively

For first time users of SaC we recommend using the Jupyter Notebook environment.

Pull the most recent image with:

```bash
docker pull sacbase/sac-jupyter-notebook
```

And start the Jupyter notebook using:

```bash
docker run -p 8888:8888 sacbase/sac-jupyter-notebook
```

After the container has started multiple URLs will be printed; use the one starting with `127.0.0.1:8888`.

## Local development with Visual Studio Code

For compiling SaC programs we recommend the [sac-compiler](https://hub.docker.com/r/sacbase/sac-compiler) Docker container.

Using this container with Visual Studio Code requires the `Dev Containers` extension.
Check the [documentation](https://code.visualstudio.com/docs/devcontainers/containers) for a comprehensive tutorial.

In short: first add the following `.devcontainer.json` file to your local development directory

```json
{
  "image": "sacbase/sac-compiler"
}
```

In VS Code run the `Dev Containers: Open Folder in Container...` command from the Command Palette (`F1`).

You have now opened your local development directory within the SaC Docker container, with full access to the `sac2c` compiler and standard library.
Happy developing!
