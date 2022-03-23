# Copyright (c) 2021-2022 SaC Development Team.

FROM jupyter/minimal-notebook:latest

LABEL maintainer="SaC Development Team <info@sac-home.org>"

ENV SACVER=1.3.3-798-1
ENV SAC2CVER=1.3.3-MijasCosta-798-g229c5
ENV STDLIBVER=1.3-144-g935a-dirty

USER root

# Install all OS dependencies for fully functional notebook server
RUN apt-get update && apt-get install -yq --no-install-recommends \
      build-essential \
      git \
      && apt-get clean && apt-get autoclean && apt-get --purge autoremove

# Install SaC compiler and stdlib
ADD https://gitlab.sac-home.org/sac-group/sac-packages/-/raw/master/packages/alternative/jupyter/${SACVER}/basic/sac2c-${SAC2CVER}-omnibus.deb .
ADD https://gitlab.sac-home.org/sac-group/sac-packages/-/raw/master/packages/alternative/jupyter/${SACVER}/basic/sac-stdlib-${STDLIBVER}.deb .
RUN apt-get install -yq ./sac2c-$SAC2CVER-omnibus.deb \
    && apt-get install -yq ./sac-stdlib-$STDLIBVER.deb \
    && rm *.deb \
# clear APT cache (make image smaller)
    && apt-get clean && apt-get autoclean && apt-get --purge autoremove \
    && rm -rf /var/lib/apt/lists/*

# ensure we can use jupyter console
RUN conda install -y -q -c conda-forge jupyter_console \
    && conda clean -a -y -q

# install SaC Pygments
RUN cd /home/$ND_USER && mkdir temp && cd temp \
    && git clone https://github.com/SacBase/sac-pygments.git \
    && cd sac-pygments \
    && python setup.py install \
    && cd /home/$ND_USER && rm -rf temp

# install SaC Jupyter kernel
RUN cd /home/$NB_USER \
    && git clone https://github.com/SacBase/sac-jupyter.git .sac-jupyter \
    && cd .sac-jupyter \
    && mkdir -p /home/$NB_USER/.local/share/jupyter/kernels/sac \
    && echo "{\"argv\": [\"python3\", \"/home/$NB_USER/.sac-jupyter/kernel.py\", \"-f\", \"{connection_file}\"], \"display_name\": \"SaC\", \"language\": \"sac\" }" > /home/$NB_USER/.local/share/jupyter/kernels/sac/kernel.json \
    && cp sac/kernel.js /home/$NB_USER/.local/share/jupyter/kernels/sac \
    && chown -R $NB_USER:users /home/$NB_USER

USER $NB_UID

# add sac logo
COPY --chown=$NB_UID:$NB_GID logo-ext.png $HOME/.jupyter/custom/logo.png
COPY --chown=$NB_UID:$NB_GID custom.css $HOME/.jupyter/custom/

# disable python kernel, set sac as default kernel
RUN echo y | jupyter notebook --generate-config && echo y | jupyter server --generate-config \
    && echo -e "c.KernelSpecManager.ensure_native_kernel=False\nc.MappingKernelManager.default_kernel_name='sac'" \
    >> /home/$NB_USER/.jupyter/jupyter_notebook_config.py \
    && echo -e "c.KernelSpecManager.ensure_native_kernel=False\nc.MappingKernelManager.default_kernel_name='sac'" \
    >> /home/$NB_USER/.jupyter/jupyter_server_config.py \
    && echo y | jupyter kernelspec uninstall python3

# add example notebook
COPY --chown=$NB_UID:$NB_GID sac-example-notebook.ipynb $HOME/

