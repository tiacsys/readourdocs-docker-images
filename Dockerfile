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

# Localization dependencies
RUN apt-get -y install \
      locales

# Setup locales for German
RUN locale-gen de_DE.UTF-8
RUN update-locale LANG=de_DE.UTF-8
ENV LANG=de_DE.UTF-8
RUN locale -a

# Setup locales for English
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8
RUN locale -a

# Tools for international spelling check
RUN apt-get -y install \
      aspell \
      enchant-2 \
      hunspell
RUN apt-get -y autoremove --purge
RUN apt-get clean

# Dictionaries for spelling check -- split to reduce image layer size
RUN apt-get -y install \
      aspell-en \
      hunspell-en-us \
      hunspell-en-med
RUN apt-get -y autoremove --purge
RUN apt-get clean

# Dictionaries for spelling check -- split to reduce image layer size
RUN apt-get -y install \
      aspell-de \
      hunspell-de-de \
      hunspell-de-med \
      myspell-de-de-1901
RUN apt-get -y autoremove --purge
RUN apt-get clean

# Dictionaries for spelling check -- split to reduce image layer size
RUN apt-get -y install \
      wamerican-huge \
      wgerman-medical \
      wngerman
RUN apt-get -y autoremove --purge
RUN apt-get clean

# graphviz: is to support sphinx.ext.graphviz
# https://www.sphinx-doc.org/en/master/usage/extensions/graphviz.html
#
# imagemagick: is to support sphinx.ext.imgconverter
# http://www.sphinx-doc.org/en/master/usage/extensions/imgconverter.html
#
# rsvg-convert: is for SVG -> PDF conversion
# using Sphinx extension sphinxcontrib.rsvgconverter, see
# https://github.com/missinglinkelectronics/sphinxcontrib-svg2pdfconverter
#
# plantuml: is to support sphinxcontrib-plantuml
# https://pypi.org/project/sphinxcontrib-plantuml
#
# pdf2svg (poppler-utils): is required for different workflows,
# needed to convert PDF -> SVG conversion, alternative to pdftocairo, see
# http://cityinthesky.co.uk/opensource/pdf2svg
# https://poppler.freedesktop.org/
#
# swig: is required for different purposes
# https://github.com/readthedocs/readthedocs-docker-images/issues/15
RUN apt-get -y install \
      graphviz \
      imagemagick \
      librsvg2-bin \
      pdf2svg \
      plantuml \
      poppler-utils \
      swig
RUN apt-get -y autoremove --purge
RUN apt-get clean

# LaTeX -- split to reduce image layer size
RUN apt-get -y install \
    texlive-fonts-extra \
    texlive-fonts-recommended
RUN apt-get -y install \
    texlive-lang-english \
    texlive-lang-european
RUN apt-get -y install \
    texlive-pictures \
    texlive-science \
    texlive-xetex
RUN apt-get -y autoremove --purge
RUN apt-get clean

# latexmk: is needed to generate LaTeX documents
# https://github.com/readthedocs/readthedocs.org/issues/4454
RUN apt-get -y install \
    latexmk
RUN apt-get -y autoremove --purge
RUN apt-get clean

# asdf Python 3.6.15 extra requirements
# https://github.com/pyenv/pyenv/issues/1889#issuecomment-833587851
RUN apt-get install -y \
    clang
RUN apt-get -y autoremove --purge
RUN apt-get clean

# building Python scipy extra requirements
# https://docs.scipy.org/doc/scipy/dev/contributor/building.html
RUN apt-get install -y \
    gfortran \
    liblapack-dev \
    libopenblas-dev
RUN apt-get -y autoremove --purge
RUN apt-get clean

# ensure Python3 from the system installed
RUN apt-get install -y \
    python3 \
    python3-dev \
    python3-pip \
    python3-venv
RUN apt-get -y autoremove --purge
RUN apt-get clean

# running Chromium within DeckTape extra requirements
RUN apt-get install -y \
    libasound2 \
    libgbm1
RUN apt-get -y autoremove --purge
RUN apt-get clean

#
# Manage multiple runtime versions with the
# asdf version manager in docs user space.
#

USER docs
WORKDIR /home/docs

# Upgrade asdf version manager
# https://github.com/asdf-vm/asdf
RUN asdf update
RUN asdf version

#
# Rust runtime versions
#

# Define Rust versions to be installed via asdf
### __NOT_YET__ ### ENV ROD_RUST_VERSION_2020=1.49.0
### __NOT_YET__ ### ENV ROD_RUST_VERSION_2021=1.57.0
ENV ROD_RUST_VERSION_2022=1.66.0

### __NOT_YET__ ### RUN asdf install rust $ROD_RUST_VERSION_2020 && \
### __NOT_YET__ ###     asdf global  rust $ROD_RUST_VERSION_2020 && \
### __NOT_YET__ ###     asdf reshim  rust

### __NOT_YET__ ### RUN asdf install rust $ROD_RUST_VERSION_2021 && \
### __NOT_YET__ ###     asdf global  rust $ROD_RUST_VERSION_2021 && \
### __NOT_YET__ ###     asdf reshim  rust

RUN asdf install rust $ROD_RUST_VERSION_2022 && \
    asdf global  rust $ROD_RUST_VERSION_2022 && \
    asdf reshim  rust

# Adding labels for external usage
### __NOT_YET__ ### LABEL rust.version_2020=$ROD_RUST_VERSION_2020
### __NOT_YET__ ### LABEL rust.version_2021=$ROD_RUST_VERSION_2021
LABEL rust.version_2022=$ROD_RUST_VERSION_2022

RUN asdf local rust $ROD_RUST_VERSION_2022
RUN asdf list  rust

#
# Golang runtime versions
#

# Define Golang versions to be installed via asdf
### __NOT_YET__ ### ENV ROD_GOLANG_VERSION_115=1.15.15
### __NOT_YET__ ### ENV ROD_GOLANG_VERSION_116=1.16.15
### __NOT_YET__ ### ENV ROD_GOLANG_VERSION_117=1.17.13
ENV ROD_GOLANG_VERSION_118=1.18.9
### __NOT_YET__ ### ENV ROD_GOLANG_VERSION_119=1.19.4

### __NOT_YET__ ### RUN asdf install golang $ROD_GOLANG_VERSION_115 && \
### __NOT_YET__ ###     asdf global  golang $ROD_GOLANG_VERSION_115 && \
### __NOT_YET__ ###     asdf reshim  golang

### __NOT_YET__ ### RUN asdf install golang $ROD_GOLANG_VERSION_116 && \
### __NOT_YET__ ###     asdf global  golang $ROD_GOLANG_VERSION_116 && \
### __NOT_YET__ ###     asdf reshim  golang

### __NOT_YET__ ### RUN asdf install golang $ROD_GOLANG_VERSION_117 && \
### __NOT_YET__ ###     asdf global  golang $ROD_GOLANG_VERSION_117 && \
### __NOT_YET__ ###     asdf reshim  golang

RUN asdf install golang $ROD_GOLANG_VERSION_118 && \
    asdf global  golang $ROD_GOLANG_VERSION_118 && \
    asdf reshim  golang

### __NOT_YET__ ### RUN asdf install golang $ROD_GOLANG_VERSION_119 && \
### __NOT_YET__ ###     asdf global  golang $ROD_GOLANG_VERSION_119 && \
### __NOT_YET__ ###     asdf reshim  golang

# Adding labels for external usage
### __NOT_YET__ ### LABEL golang.version_115=$ROD_GOLANG_VERSION_115
### __NOT_YET__ ### LABEL golang.version_116=$ROD_GOLANG_VERSION_116
### __NOT_YET__ ### LABEL golang.version_117=$ROD_GOLANG_VERSION_117
LABEL golang.version_118=$ROD_GOLANG_VERSION_118
### __NOT_YET__ ### LABEL golang.version_119=$ROD_GOLANG_VERSION_119

RUN asdf local golang $ROD_GOLANG_VERSION_118
RUN asdf list  golang

#
# Node.js runtime versions
#

# Define Node.js versions to be installed via asdf
### __NOT_YET__ ### ENV ROD_NODEJS_VERSION_12=12.22.12
### __NOT_YET__ ### ENV ROD_NODEJS_VERSION_14=14.21.2
### __NOT_YET__ ### ENV ROD_NODEJS_VERSION_16=16.19.0
ENV ROD_NODEJS_VERSION_18=18.12.1
### __NOT_YET__ ### ENV ROD_NODEJS_VERSION_19=19.3.0

### __NOT_YET__ ### RUN asdf install nodejs $ROD_NODEJS_VERSION_12 && \
### __NOT_YET__ ###     asdf global  nodejs $ROD_NODEJS_VERSION_12 && \
### __NOT_YET__ ###     asdf reshim  nodejs

### __NOT_YET__ ### RUN asdf install nodejs $ROD_NODEJS_VERSION_14 && \
### __NOT_YET__ ###     asdf global  nodejs $ROD_NODEJS_VERSION_14 && \
### __NOT_YET__ ###     asdf reshim  nodejs

### __NOT_YET__ ### RUN asdf install nodejs $ROD_NODEJS_VERSION_16 && \
### __NOT_YET__ ###     asdf global  nodejs $ROD_NODEJS_VERSION_16 && \
### __NOT_YET__ ###     asdf reshim  nodejs

RUN asdf install nodejs $ROD_NODEJS_VERSION_18 && \
    asdf global  nodejs $ROD_NODEJS_VERSION_18 && \
    asdf reshim  nodejs

### __NOT_YET__ ### RUN asdf install nodejs $ROD_NODEJS_VERSION_19 && \
### __NOT_YET__ ###     asdf global  nodejs $ROD_NODEJS_VERSION_19 && \
### __NOT_YET__ ###     asdf reshim  nodejs

# Adding labels for external usage
### __NOT_YET__ ### LABEL nodejs.version_12=$ROD_NODEJS_VERSION_12
### __NOT_YET__ ### LABEL nodejs.version_14=$ROD_NODEJS_VERSION_14
### __NOT_YET__ ### LABEL nodejs.version_16=$ROD_NODEJS_VERSION_16
LABEL nodejs.version_18=$ROD_NODEJS_VERSION_18
### __NOT_YET__ ### LABEL nodejs.version_19=$ROD_NODEJS_VERSION_19

RUN asdf local nodejs $ROD_NODEJS_VERSION_18
RUN asdf list  nodejs

CMD ["/bin/bash"]
