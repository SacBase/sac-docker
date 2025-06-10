FROM jupyter/base-notebook:latest

LABEL maintainer="SaC Development Team <info@sac-home.org>"

USER root

RUN apt update \
    && apt install -y --no-install-recommends \
        build-essential \
        ca-certificates \
        cmake \
        git \
        xsltproc \
        python3 \
        pipx \
        bison \
        flex \
        m4 \
    && apt clean \
    && apt autoclean \
    && apt --purge autoremove

WORKDIR /home/$NB_USER

# Build and install SaC compiler
RUN git clone --recursive --single-branch https://gitlab.sac-home.org/sac-group/sac2c.git \
    && cd sac2c \
    && mkdir build && cd build \
    && cmake -DCMAKE_BUILD_TYPE=RELEASE .. \
    && make -j4 \
    && cp sac2c_p /usr/local/bin/sac2c \
    && sac2c -V \
    && cd /home/$NB_USER \
    && rm -r sac2c

# Build and install SaC standard library
RUN git clone --recursive --single-branch https://github.com/SacBase/Stdlib.git \
    && cd Stdlib \
    && mkdir build && cd build \
    && cmake -DBUILD_EXT=OFF -DFULLTYPES=OFF -DTARGETS="seq;seq_checks" .. \
    && make -j4 \
    && cd /home/$NB_USER \
    && rm -r Stdlib

# Install SaC Jupyter kernel
RUN git clone --single-branch https://github.com/SacBase/sac-jupyter.git \
    && cd sac-jupyter \
    && mkdir -p /home/$NB_USER/.local/share/jupyter/kernels/sac \
    && echo "{\"argv\": [\"python3\", \"/home/$NB_USER/sac-jupyter/kernel.py\", \"-f\", \"{connection_file}\"], \"display_name\": \"SaC\", \"language\": \"sac\" }" > /home/$NB_USER/.local/share/jupyter/kernels/sac/kernel.json \
    && cp sac/kernel.js /home/$NB_USER/.local/share/jupyter/kernels/sac \
    && chown -R $NB_USER:users /home/$NB_USER

USER $NB_UID
