# Read Our Docs - Environment base
#
#  -- derived from Read The Docs base environment
#  -- see: https://hub.docker.com/r/readthedocs/build/tags
#  -- see: https://github.com/readthedocs/readthedocs-docker-images
#
#  -- derived from Ubuntu official Docker image
#  -- see: https://hub.docker.com/_/ubuntu/tags
#  -- see: https://github.com/docker-library/official-images
#
FROM readthedocs/build:ubuntu-24.04-2024.06.17
LABEL mantainer="Stephan Linz <stephan.linz@tiac-systems.de>"
LABEL version="unstable"

LABEL org.opencontainers.image.vendor="TiaC Systems Network"
LABEL org.opencontainers.image.authors="Stephan Linz <stephan.linz@tiac-systems.de>"
LABEL org.opencontainers.image.documentation="https://github.com/tiacsys/readourdocs-docker-images/blob/main/README.md"

# ############################################################################

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8

USER root
WORKDIR /

# ############################################################################

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

# ############################################################################

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

# ############################################################################

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

# ############################################################################

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

# ############################################################################

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
    libasound2t64 \
    libgbm1
RUN apt-get -y autoremove --purge
RUN apt-get clean

# asdf OpenJDK 21 extra requirements
RUN apt-get install -y \
    openjdk-21-jdk
RUN apt-get -y autoremove --purge
RUN apt-get clean

# ############################################################################

#
# Manage multiple runtime versions with the
# asdf version manager in docs user space.
#

USER docs
WORKDIR /home/docs

# Upgrade asdf version manager
# https://github.com/asdf-vm/asdf
RUN asdf update
RUN asdf plugin update --all
RUN asdf version

# Install asdf plugins
RUN asdf plugin add pipx https://github.com/yozachar/asdf-pipx.git

# ############################################################################

#
# Rust runtime versions
# https://releases.rs/
#

# Define Rust versions to be installed via asdf
ENV ROD_RUST_VERSION_2022=1.67.1
ENV ROD_RUST_VERSION_2023=1.76.0
ENV ROD_RUST_VERSION_2024=1.81.0

# Install Rust versions
RUN asdf install rust $ROD_RUST_VERSION_2022 && \
    asdf global  rust $ROD_RUST_VERSION_2022 && \
    asdf reshim  rust

RUN asdf install rust $ROD_RUST_VERSION_2023 && \
    asdf global  rust $ROD_RUST_VERSION_2023 && \
    asdf reshim  rust

RUN asdf install rust $ROD_RUST_VERSION_2024 && \
    asdf global  rust $ROD_RUST_VERSION_2024 && \
    asdf reshim  rust

# Adding labels for external usage
LABEL rust.version_2022=$ROD_RUST_VERSION_2022
LABEL rust.version_2023=$ROD_RUST_VERSION_2023
LABEL rust.version_2024=$ROD_RUST_VERSION_2024

# Set default Rust version
RUN asdf local rust $ROD_RUST_VERSION_2024
RUN asdf list  rust

# ############################################################################

#
# Golang runtime versions
# https://go.dev/doc/devel/release
#

# Define Golang versions to be installed via asdf
ENV ROD_GOLANG_VERSION_2022=1.19.13
ENV ROD_GOLANG_VERSION_2023=1.21.13
ENV ROD_GOLANG_VERSION_2024=1.23.1

# Install Golang versions
RUN asdf install golang $ROD_GOLANG_VERSION_2022 && \
    asdf global  golang $ROD_GOLANG_VERSION_2022 && \
    asdf reshim  golang

RUN asdf install golang $ROD_GOLANG_VERSION_2023 && \
    asdf global  golang $ROD_GOLANG_VERSION_2023 && \
    asdf reshim  golang

RUN asdf install golang $ROD_GOLANG_VERSION_2024 && \
    asdf global  golang $ROD_GOLANG_VERSION_2024 && \
    asdf reshim  golang

# Adding labels for external usage
LABEL golang.version_2022=$ROD_GOLANG_VERSION_2022
LABEL golang.version_2023=$ROD_GOLANG_VERSION_2023
LABEL golang.version_2024=$ROD_GOLANG_VERSION_2024

# Set default Golang version
RUN asdf local golang $ROD_GOLANG_VERSION_2024
RUN asdf list  golang

# ############################################################################

#
# Node.js runtime versions
# https://nodejs.org/en/about/previous-releases
#

# Define Node.js versions to be installed via asdf
ENV ROD_NODEJS_VERSION_18=18.20.4
ENV ROD_NODEJS_VERSION_20=20.17.0
ENV ROD_NODEJS_VERSION_22=22.9.0

# Install Node.js versions
RUN asdf install nodejs $ROD_NODEJS_VERSION_18 && \
    asdf global  nodejs $ROD_NODEJS_VERSION_18 && \
    asdf reshim  nodejs

RUN asdf install nodejs $ROD_NODEJS_VERSION_20 && \
    asdf global  nodejs $ROD_NODEJS_VERSION_20 && \
    asdf reshim  nodejs

RUN asdf install nodejs $ROD_NODEJS_VERSION_22 && \
    asdf global  nodejs $ROD_NODEJS_VERSION_22 && \
    asdf reshim  nodejs

# Adding labels for external usage
LABEL nodejs.version_18=$ROD_NODEJS_VERSION_18
LABEL nodejs.version_20=$ROD_NODEJS_VERSION_20
LABEL nodejs.version_22=$ROD_NODEJS_VERSION_22

# Set default Node.js version
RUN asdf local nodejs $ROD_NODEJS_VERSION_22
RUN asdf list  nodejs

# ############################################################################

#
# Ruby runtime versions
# https://www.ruby-lang.org/en/downloads/branches
# https://www.ruby-lang.org/en/downloads/releases
#

# Define Ruby versions to be installed via asdf
ENV ROD_RUBY_VERSION_31=3.1.6
ENV ROD_RUBY_VERSION_32=3.2.5
ENV ROD_RUBY_VERSION_33=3.3.5

# Install Ruby versions
RUN asdf install ruby $ROD_RUBY_VERSION_31 && \
    asdf global  ruby $ROD_RUBY_VERSION_31 && \
    asdf reshim  ruby

RUN asdf install ruby $ROD_RUBY_VERSION_32 && \
    asdf global  ruby $ROD_RUBY_VERSION_32 && \
    asdf reshim  ruby

RUN asdf install ruby $ROD_RUBY_VERSION_33 && \
    asdf global  ruby $ROD_RUBY_VERSION_33 && \
    asdf reshim  ruby

# Adding labels for external usage
LABEL ruby.version_31=$ROD_RUBY_VERSION_31
LABEL ruby.version_32=$ROD_RUBY_VERSION_32
LABEL ruby.version_33=$ROD_RUBY_VERSION_33

# Set default Ruby version
RUN asdf local ruby $ROD_RUBY_VERSION_33
RUN asdf list  ruby

# ############################################################################

#
# PyPA pipx for Python runtime version
# https://repology.org/project/pipx/versions
# https://pipx.pypa.io/stable/installation
# https://github.com/pypa/pipx
#

# Define pipx version to be installed via asdf
ENV ROD_PIPX_VERSION=1.7.1

# Install pipx version
RUN asdf install pipx $ROD_PIPX_VERSION && \
    asdf global  pipx $ROD_PIPX_VERSION && \
    asdf reshim  pipx

# Adding labels for external usage
LABEL pipx.version=$ROD_PIPX_VERSION

# Set default pipx version
RUN asdf local pipx $ROD_PIPX_VERSION
RUN asdf list  pipx

# Ensure PATH environment variable for pipx
RUN pipx ensurepath

# ############################################################################

#
# Python runtime versions
# https://www.python.org/downloads
# https://devguide.python.org/versions
#
# PyPy runtime versions
# https://downloads.python.org/pypy
# https://pypy.org/download_advanced.html
# https://pypy.org/categories/release.html
# https://doc.pypy.org/en/latest/index-of-release-notes.html
#

# Define Python versions to be installed via asdf
ENV ROD_PYTHON_VERSION_27=2.7.18
ENV ROD_PYTHON_VERSION_310=3.10.15
ENV ROD_PYTHON_VERSION_312=3.12.7
ENV ROD_PYPY_VERSION_2=pypy2.7-7.3.17
ENV ROD_PYPY_VERSION_3=pypy3.10-7.3.17

ENV PYTHON_CONFIGURE_OPTS=--enable-shared

# Install Python versions
RUN asdf install python $ROD_PYTHON_VERSION_27 && \
    asdf global  python $ROD_PYTHON_VERSION_27 && \
    asdf reshim  python

RUN asdf install python $ROD_PYTHON_VERSION_310 && \
    asdf global  python $ROD_PYTHON_VERSION_310 && \
    asdf reshim  python

RUN asdf install python $ROD_PYTHON_VERSION_312 && \
    asdf global  python $ROD_PYTHON_VERSION_312 && \
    asdf reshim  python

RUN asdf install python $ROD_PYPY_VERSION_2 && \
    asdf global  python $ROD_PYPY_VERSION_2 && \
    asdf reshim  python

RUN asdf install python $ROD_PYPY_VERSION_3 && \
    asdf global  python $ROD_PYPY_VERSION_3 && \
    asdf reshim  python

# Python2 dependencies are hardcoded because Python2 is
# deprecated. Updating them to their latest versions may raise
# incompatibility issues.
RUN asdf local python $ROD_PYTHON_VERSION_27 && \
    pip install --upgrade pip==20.3.4 && \
    pip install --upgrade setuptools==44.1.1 && \
    pip install --upgrade virtualenv==20.15.1 && \
    pip install --upgrade wheel==0.37.1 && \
    pip install --upgrade poetry==1.1.15 && \
    pip install --only-binary numpy,scipy numpy==1.16.6 scipy==1.2.3 && \
    pip install --only-binary pandas,matplotlib pandas==0.24.2 matplotlib==2.2.5

RUN asdf local python $ROD_PYPY_VERSION_2 && \
    pip install --upgrade pip==20.3.4 && \
    pip install --upgrade setuptools==44.1.1 && \
    pip install --upgrade virtualenv==20.15.1 && \
    pip install --upgrade wheel==0.37.1 && \
    pip install --upgrade poetry==1.1.15

# Define Python package versions to be installed via pip
ENV ROD_PIP_VERSION=24.2
ENV ROD_SETUPTOOLS_VERSION=75.1.0
ENV ROD_VIRTUALENV_VERSION=20.26.6
ENV ROD_WHEEL_VERSION=0.44.0
ENV ROD_POETRY_VERSION=1.8.3
ENV ROD_WEST_VERSION=1.2.0

# Install Python package versions
RUN asdf local python $ROD_PYTHON_VERSION_310 && \
    pip install --upgrade pip==$ROD_PIP_VERSION && \
    pip install --upgrade setuptools==$ROD_SETUPTOOLS_VERSION && \
    pip install --upgrade virtualenv==$ROD_VIRTUALENV_VERSION && \
    pip install --upgrade wheel==$ROD_WHEEL_VERSION && \
    pip install --upgrade poetry==$ROD_POETRY_VERSION && \
    pip install --upgrade west==$ROD_WEST_VERSION && \
    pip install --only-binary numpy,scipy numpy scipy && \
    pip install --only-binary pandas,matplotlib pandas matplotlib

RUN asdf local python $ROD_PYTHON_VERSION_312 && \
    pip install --upgrade pip==$ROD_PIP_VERSION && \
    pip install --upgrade setuptools==$ROD_SETUPTOOLS_VERSION && \
    pip install --upgrade virtualenv==$ROD_VIRTUALENV_VERSION && \
    pip install --upgrade wheel==$ROD_WHEEL_VERSION && \
    pip install --upgrade poetry==$ROD_POETRY_VERSION && \
    pip install --upgrade west==$ROD_WEST_VERSION && \
    pip install --only-binary numpy,scipy numpy scipy && \
    pip install --only-binary pandas,matplotlib pandas matplotlib

RUN asdf local python $ROD_PYPY_VERSION_3 && \
    pip install --upgrade pip==$ROD_PIP_VERSION && \
    pip install --upgrade setuptools==$ROD_SETUPTOOLS_VERSION && \
    pip install --upgrade virtualenv==$ROD_VIRTUALENV_VERSION && \
    pip install --upgrade wheel==$ROD_WHEEL_VERSION && \
    pip install --upgrade poetry==$ROD_POETRY_VERSION && \
    pip install --upgrade west==$ROD_WEST_VERSION

# Adding labels for external usage
LABEL python.version_27=$ROD_PYTHON_VERSION_27
LABEL python.version_310=$ROD_PYTHON_VERSION_310
LABEL python.version_312=$ROD_PYTHON_VERSION_312
LABEL pypy.version_2=$ROD_PYPY_VERSION_2
LABEL pypy.version_3=$ROD_PYPY_VERSION_3
LABEL python.pip=$ROD_PIP_VERSION
LABEL python.setuptools=$ROD_SETUPTOOLS_VERSION
LABEL python.virtualenv=$ROD_VIRTUALENV_VERSION
LABEL python.wheel=$ROD_WHEEL_VERSION
LABEL python.poetry=$ROD_POETRY_VERSION
LABEL python.west=$ROD_WEST_VERSION

# Define Python package versions to be installed via pipx
ENV ROD_POETRY_VERSION_15=1.5.1
ENV ROD_POETRY_VERSION_14=1.4.2
ENV ROD_POETRY_VERSION_13=1.3.2
ENV ROD_POETRY_VERSION_12=1.2.2
ENV ROD_POETRY_VERSION_11=1.1.15

# Install Python 3.10 package versions
RUN asdf local python $ROD_PYTHON_VERSION_310 && \
    pipx install --suffix=@$ROD_POETRY_VERSION_15 \
                   poetry==$ROD_POETRY_VERSION_15 && \
    pipx pin       poetry@$ROD_POETRY_VERSION_15 && \
    pipx install --suffix=@$ROD_POETRY_VERSION_14 \
                   poetry==$ROD_POETRY_VERSION_14 && \
    pipx pin       poetry@$ROD_POETRY_VERSION_14 && \
    pipx install --suffix=@$ROD_POETRY_VERSION_13 \
                   poetry==$ROD_POETRY_VERSION_13 && \
    pipx pin       poetry@$ROD_POETRY_VERSION_13 && \
    pipx install --suffix=@$ROD_POETRY_VERSION_12 \
                   poetry==$ROD_POETRY_VERSION_12 && \
    pipx pin       poetry@$ROD_POETRY_VERSION_12 && \
    pipx install --suffix=@$ROD_POETRY_VERSION_11 \
                   poetry==$ROD_POETRY_VERSION_11 && \
    pipx pin       poetry@$ROD_POETRY_VERSION_11

# Adding labels for external usage
LABEL python.poetry_15=$ROD_POETRY_VERSION_15
LABEL python.poetry_14=$ROD_POETRY_VERSION_14
LABEL python.poetry_13=$ROD_POETRY_VERSION_13
LABEL python.poetry_12=$ROD_POETRY_VERSION_12
LABEL python.poetry_11=$ROD_POETRY_VERSION_11

# Set default Python version
RUN asdf local python $ROD_PYTHON_VERSION_312
RUN asdf list  python

# ############################################################################

# Set executable for main entry point
CMD ["/bin/bash"]
