# We get the latest ArchLinux image with
# `base-devel` installed
FROM sacbuild/ubuntu18:1.0.14

# some information
LABEL maintainer="info@sac-home.org"
LABEL version="1.3.3-359-1"

# environment
ENV SAC_VER "1.3.3-MijasCosta-359-g856d44"
ENV SAC_SHORT_VER "1.3.3-359-1"
ENV SAC_TYPE "full"

# get DEB from website
RUN mkdir -p /tmp \
  && curl -OL http://www.sac-home.org/packages/weekly/Ubl18/${SAC_SHORT_VER}/${SAC_TYPE}/sac2c-${SAC_VER}-omnibus.deb \
  && dpkg -i sac2c-${SAC_VER}-omnibus.deb \
  && rm sac2c-${SAC_VER}-omnibus.deb

HEALTHCHECK CMD sac2c -V
