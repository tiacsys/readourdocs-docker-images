# Read Our Docs - Environment base
#
#  -- derived from Read The Docs base environment
#  -- see: https://hub.docker.com/r/readthedocs/build
#  -- see: https://github.com/readthedocs/readthedocs-docker-images
#
FROM readthedocs/build:ubuntu-22.04-2022.03.15
LABEL mantainer="Stephan Linz <stephan.linz@navimatix.de>"
LABEL version="unstable"

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8

USER root
WORKDIR /

# System dependencies
RUN apt-get -y update
RUN apt-get -y dist-upgrade
RUN apt-get -y autoremove --purge
RUN apt-get clean

CMD ["/bin/bash"]
