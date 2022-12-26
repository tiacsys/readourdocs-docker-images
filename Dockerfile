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

CMD ["/bin/bash"]
