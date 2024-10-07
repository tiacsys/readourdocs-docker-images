# Read Our Docs - Environment base
#
#  -- derived from official Ubuntu Docker image
#  -- see: https://hub.docker.com/_/ubuntu/tags
#  -- see: https://github.com/docker-library/official-images
#
#  -- support Docker multi-platform image build
#  -- see: https://docs.docker.com/build/building/multi-platform
#  -- see: https://docs.docker.com/build/building/variables/#multi-platform-build-arguments
#
#  -- TARGETPLATFORM=linux/amd64: TARGETOS=linux, TARGETARCH=amd64, TARGETVARIANT=
#  -- TARGETPLATFORM=linux/arm/v7: TARGETOS=linux, TARGETARCH=arm, TARGETVARIANT=v7
#  -- TARGETPLATFORM=linux/arm64: TARGETOS=linux, TARGETARCH=arm64, TARGETVARIANT=
#

# ############################################################################
#
# Base system maintenance with official Ubuntu Docker image
#
# ############################################################################

FROM ubuntu:noble-20240904.1 AS base

LABEL mantainer="Stephan Linz <stephan.linz@tiac-systems.de>"
LABEL version="unstable"

LABEL org.opencontainers.image.vendor="TiaC Systems Network"
LABEL org.opencontainers.image.authors="Stephan Linz <stephan.linz@tiac-systems.de>"
LABEL org.opencontainers.image.documentation="https://github.com/tiacsys/readourdocs-docker-images/blob/main/README.md"

# ############################################################################

#
# asdf-vm runtime version
# https://asdf-vm.com/
# https://github.com/asdf-vm/asdf/blob/master/CHANGELOG.md
#

# Define asdf-vm branch to be installed via git-clone
ENV ROD_ASDF_BRANCH=v0.14.1

#
# Rust runtime versions
# https://releases.rs/
#

# Define Rust versions to be installed via asdf
ENV ROD_RUST_VERSION_2024=1.81.0
ENV ROD_RUST_VERSION_2023=1.76.0
ENV ROD_RUST_VERSION_2022=1.67.1

#
# Golang runtime versions
# https://go.dev/doc/devel/release
#

# Define Golang versions to be installed via asdf
ENV ROD_GOLANG_VERSION_2024=1.23.1
ENV ROD_GOLANG_VERSION_2023=1.21.13
ENV ROD_GOLANG_VERSION_2022=1.19.13

#
# Node.js runtime versions
# https://nodejs.org/en/about/previous-releases
#

# Define Node.js versions to be installed via asdf
ENV ROD_NODEJS_VERSION_22=22.9.0
ENV ROD_NODEJS_VERSION_20=20.17.0
ENV ROD_NODEJS_VERSION_18=18.20.4

#
# Ruby runtime versions
# https://www.ruby-lang.org/en/downloads/branches
# https://www.ruby-lang.org/en/downloads/releases
#

# Define Ruby versions to be installed via asdf
ENV ROD_RUBY_VERSION_33=3.3.5
ENV ROD_RUBY_VERSION_32=3.2.5
ENV ROD_RUBY_VERSION_31=3.1.6

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
ENV ROD_PYTHON_VERSION_312=3.12.7
ENV ROD_PYTHON_VERSION_310=3.10.15
ENV ROD_PYTHON_VERSION_27=2.7.18
ENV ROD_PYPY_VERSION_3=pypy3.10-7.3.17
ENV ROD_PYPY_VERSION_2=pypy2.7-7.3.17

# Define CPython default behaviour for compilations (shared libraries)
ENV PYTHON_CONFIGURE_OPTS=--enable-shared

# Define Python package versions to be installed via pip
ENV ROD_PIP_VERSION=24.2
ENV ROD_SETUPTOOLS_VERSION=75.1.0
ENV ROD_VIRTUALENV_VERSION=20.26.6
ENV ROD_WHEEL_VERSION=0.44.0
ENV ROD_POETRY_VERSION=1.8.3
ENV ROD_WEST_VERSION=1.2.0

#
# PyPA pipx for Python runtime version
# https://repology.org/project/pipx/versions
# https://pipx.pypa.io/stable/installation
# https://github.com/pypa/pipx
#

# Define pipx version to be installed via asdf
ENV ROD_PIPX_VERSION=1.7.1
ENV ROD_PIPX_ARGCOMPLETE_VERSION=3.5.0

# Define Python package versions to be installed via pipx
ENV ROD_POETRY_VERSION_18=1.8.3
ENV ROD_POETRY_VERSION_17=1.7.1
ENV ROD_POETRY_VERSION_16=1.6.1
ENV ROD_POETRY_VERSION_15=1.5.1
ENV ROD_POETRY_VERSION_14=1.4.2
ENV ROD_POETRY_VERSION_13=1.3.2
ENV ROD_POETRY_VERSION_12=1.2.2
ENV ROD_POETRY_VERSION_11=1.1.15

# ############################################################################

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8

USER root
WORKDIR /

# ############################################################################

# System dependencies
RUN apt-get -y update
RUN apt-get -y dist-upgrade
RUN apt-get -y install \
    software-properties-common \
    vim
RUN apt-get -y autoremove --purge
RUN apt-get clean

# Install requirements
RUN apt-get -y install \
    build-essential \
    bzr \
    curl \
    doxygen \
    g++ \
    git-core \
    graphviz-dev \
    libbz2-dev \
    libcairo2-dev \
    libenchant-2-2 \
    libevent-dev \
    libffi-dev \
    libfreetype6 \
    libfreetype6-dev \
    libgraphviz-dev \
    libjpeg8-dev \
    libjpeg-dev \
    liblcms2-dev \
    libmysqlclient-dev \
    libpq-dev \
    libreadline-dev \
    libsqlite3-dev \
    libtiff5-dev \
    libwebp-dev \
    libxml2-dev \
    libxslt1-dev \
    libxslt-dev \
    mercurial \
    pandoc \
    pkg-config \
    postgresql-client \
    subversion \
    zlib1g-dev
RUN apt-get -y autoremove --purge
RUN apt-get clean

# ############################################################################

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
    texlive-fonts-extra
RUN apt-get -y install \
    texlive-fonts-recommended
RUN apt-get -y install \
    texlive-lang-english
RUN apt-get -y install \
    texlive-lang-european
RUN apt-get -y install \
    texlive-lang-japanese
RUN apt-get -y install \
    texlive-pictures
RUN apt-get -y install \
    texlive-science
RUN apt-get -y install \
    texlive-xetex
RUN apt-get -y install \
    texlive-full
RUN apt-get -y autoremove --purge
RUN apt-get clean

# lmodern: extra fonts
# https://github.com/rtfd/readthedocs.org/issues/5494
#
# xindy: is useful to generate non-ascii indexes
# https://github.com/rtfd/readthedocs.org/issues/4454
#
# fonts-noto-cjk-extra
# fonts-hanazono: chinese fonts
# https://github.com/readthedocs/readthedocs.org/issues/6319
RUN apt-get -y install \
    fonts-symbola \
    lmodern \
    latex-cjk-chinese-arphic-bkai00mp \
    latex-cjk-chinese-arphic-gbsn00lp \
    latex-cjk-chinese-arphic-gkai00mp \
    fonts-noto-cjk-extra \
    fonts-hanazono \
    xindy

# latexmk: is needed to generate LaTeX documents
# https://github.com/readthedocs/readthedocs.org/issues/4454
RUN apt-get -y install \
    latexmk
RUN apt-get -y autoremove --purge
RUN apt-get clean

# ############################################################################

# asdf Python extra requirements
# https://github.com/pyenv/pyenv/wiki#suggested-build-environment
# https://github.com/pyenv/pyenv/issues/1889#issuecomment-833587851
RUN apt-get install -y \
    clang \
    liblzma-dev \
    libncursesw5-dev \
    libssl-dev \
    libxmlsec1-dev \
    llvm \
    make \
    tk-dev \
    wget \
    xz-utils
RUN apt-get -y autoremove --purge
RUN apt-get clean

# asdf nodejs extra requirements
# https://github.com/asdf-vm/asdf-nodejs#linux-debian
RUN apt-get install -y \
    dirmngr \
    gpg
RUN apt-get -y autoremove --purge
RUN apt-get clean

# asdf Golang extra requirements
# https://github.com/asdf-community/asdf-golang#linux-debian
RUN apt-get install -y \
    coreutils
RUN apt-get -y autoremove --purge
RUN apt-get clean

# asdf Ruby extra requirements
# https://github.com/rbenv/ruby-build/wiki#suggested-build-environment
RUN apt-get install -y \
    autoconf \
    patch \
    rustc \
    libssl-dev \
    libyaml-dev \
    libreadline6-dev \
    libgmp-dev \
    libncurses5-dev \
    libgdbm6t64 \
    libgdbm-dev \
    libdb-dev \
    uuid-dev
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

# UID and GID from readthedocs/user
RUN groupadd --gid 205 docs
RUN useradd -m --uid 1005 --gid 205 docs

USER docs
WORKDIR /home/docs

# Install asdf
RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --depth 1 --branch $ROD_ASDF_BRANCH
RUN echo ". /home/docs/.asdf/asdf.sh" >> /home/docs/.bashrc
RUN echo ". /home/docs/.asdf/completions/asdf.bash" >> /home/docs/.bashrc

# Activate asdf in current session
ENV PATH=/home/docs/.asdf/shims:/home/docs/.asdf/bin:$PATH

# Install asdf plugins
RUN asdf plugin add pipx   https://github.com/yozachar/asdf-pipx.git
RUN asdf plugin add python https://github.com/asdf-community/asdf-python.git
RUN asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
RUN asdf plugin add rust   https://github.com/code-lever/asdf-rust.git
RUN asdf plugin add golang https://github.com/asdf-community/asdf-golang.git
RUN asdf plugin add ruby   https://github.com/asdf-vm/asdf-ruby.git

# Create directories for languages installations
RUN mkdir -p /home/docs/.asdf/installs/pipx && \
    mkdir -p /home/docs/.asdf/installs/python && \
    mkdir -p /home/docs/.asdf/installs/nodejs && \
    mkdir -p /home/docs/.asdf/installs/rust && \
    mkdir -p /home/docs/.asdf/installs/golang && \
    mkdir -p /home/docs/.asdf/installs/ruby

# Adding labels for external usage
LABEL asdf.branch=$ROD_ASDF_BRANCH

# Upgrade asdf version manager
# https://github.com/asdf-vm/asdf
RUN asdf update
RUN asdf plugin update --all
RUN asdf version

# ############################################################################
#
# AMD/x86 64-bit architecture maintenance
#
# ############################################################################

FROM base AS build-amd64

# ############################################################################

#
# Rust runtime versions
#

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
#

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
#

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
#

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
# Python and PyPy runtime versions
#

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

# Set default Python version
RUN asdf local python $ROD_PYTHON_VERSION_312
RUN asdf list  python

# ############################################################################
#
# ARMv7 32-bit architecture maintenance
#
# ############################################################################

FROM base AS build-arm

# ############################################################################

#
# Rust runtime versions
#

# Install Rust versions
RUN asdf install rust $ROD_RUST_VERSION_2024 && \
    asdf global  rust $ROD_RUST_VERSION_2024 && \
    asdf reshim  rust

# Adding labels for external usage
LABEL rust.version_2024=$ROD_RUST_VERSION_2024

# Set default Rust version
RUN asdf local rust $ROD_RUST_VERSION_2024
RUN asdf list  rust

# ############################################################################

#
# Golang runtime versions
#

# Install Golang versions
RUN asdf install golang $ROD_GOLANG_VERSION_2024 && \
    asdf global  golang $ROD_GOLANG_VERSION_2024 && \
    asdf reshim  golang

# Adding labels for external usage
LABEL golang.version_2024=$ROD_GOLANG_VERSION_2024

# Set default Golang version
RUN asdf local golang $ROD_GOLANG_VERSION_2024
RUN asdf list  golang

# ############################################################################

#
# Node.js runtime versions
#

# Install Node.js versions
RUN asdf install nodejs $ROD_NODEJS_VERSION_22 && \
    asdf global  nodejs $ROD_NODEJS_VERSION_22 && \
    asdf reshim  nodejs

# Adding labels for external usage
LABEL nodejs.version_22=$ROD_NODEJS_VERSION_22

# Set default Node.js version
RUN asdf local nodejs $ROD_NODEJS_VERSION_22
RUN asdf list  nodejs

# ############################################################################

#
# Ruby runtime versions
#

# Install Ruby versions
RUN asdf install ruby $ROD_RUBY_VERSION_33 && \
    asdf global  ruby $ROD_RUBY_VERSION_33 && \
    asdf reshim  ruby

# Adding labels for external usage
LABEL ruby.version_33=$ROD_RUBY_VERSION_33

# Set default Ruby version
RUN asdf local ruby $ROD_RUBY_VERSION_33
RUN asdf list  ruby

# ############################################################################

#
# Python and PyPy runtime versions
#

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

# Python2 dependencies are hardcoded because Python2 is
# deprecated. Updating them to their latest versions may raise
# incompatibility issues.
RUN asdf local python $ROD_PYTHON_VERSION_27 && \
    pip install --upgrade pip==20.3.4 && \
    pip install --upgrade setuptools==44.1.1 && \
    pip install --upgrade virtualenv==20.15.1 && \
    pip install --upgrade wheel==0.37.1 && \
    pip install --upgrade poetry==1.1.15

# Install Python package versions
RUN asdf local python $ROD_PYTHON_VERSION_310 && \
    pip install --upgrade pip==$ROD_PIP_VERSION && \
    pip install --upgrade setuptools==$ROD_SETUPTOOLS_VERSION && \
    pip install --upgrade virtualenv==$ROD_VIRTUALENV_VERSION && \
    pip install --upgrade wheel==$ROD_WHEEL_VERSION && \
    pip install --upgrade poetry==$ROD_POETRY_VERSION && \
    pip install --upgrade west==$ROD_WEST_VERSION

RUN asdf local python $ROD_PYTHON_VERSION_312 && \
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
LABEL python.pip=$ROD_PIP_VERSION
LABEL python.setuptools=$ROD_SETUPTOOLS_VERSION
LABEL python.virtualenv=$ROD_VIRTUALENV_VERSION
LABEL python.wheel=$ROD_WHEEL_VERSION
LABEL python.poetry=$ROD_POETRY_VERSION
LABEL python.west=$ROD_WEST_VERSION

# Set default Python version
RUN asdf local python $ROD_PYTHON_VERSION_312
RUN asdf list  python

# ############################################################################
#
# ARMv8 64-bit architecture maintenance
#
# ############################################################################

FROM base AS build-arm64

# ############################################################################

#
# Rust runtime versions
#

# Install Rust versions
RUN asdf install rust $ROD_RUST_VERSION_2024 && \
    asdf global  rust $ROD_RUST_VERSION_2024 && \
    asdf reshim  rust

# Adding labels for external usage
LABEL rust.version_2024=$ROD_RUST_VERSION_2024

# Set default Rust version
RUN asdf local rust $ROD_RUST_VERSION_2024
RUN asdf list  rust

# ############################################################################

#
# Golang runtime versions
#

# HOTFIX: Avoid silent failure, with reason inside of curl
# <- curl: (55) Send failure: Broken pipe
# <- OpenSSL SSL_write: Broken pipe, errno 32
RUN echo "--insecure" > /home/docs/.curlrc

# Install Golang versions
RUN asdf install golang $ROD_GOLANG_VERSION_2024 && \
    asdf global  golang $ROD_GOLANG_VERSION_2024 && \
    asdf reshim  golang

# HOTFIX: Revert silent failure hotfix from above
RUN rm -f /home/docs/.curlrc

# Adding labels for external usage
LABEL golang.version_2024=$ROD_GOLANG_VERSION_2024

# Set default Golang version
RUN asdf local golang $ROD_GOLANG_VERSION_2024
RUN asdf list  golang

# ############################################################################

#
# Node.js runtime versions
#

# Install Node.js versions
RUN asdf install nodejs $ROD_NODEJS_VERSION_22 && \
    asdf global  nodejs $ROD_NODEJS_VERSION_22 && \
    asdf reshim  nodejs

# Adding labels for external usage
LABEL nodejs.version_22=$ROD_NODEJS_VERSION_22

# Set default Node.js version
RUN asdf local nodejs $ROD_NODEJS_VERSION_22
RUN asdf list  nodejs

# ############################################################################

#
# Ruby runtime versions
#

# Install Ruby versions
RUN asdf install ruby $ROD_RUBY_VERSION_33 && \
    asdf global  ruby $ROD_RUBY_VERSION_33 && \
    asdf reshim  ruby

# Adding labels for external usage
LABEL ruby.version_33=$ROD_RUBY_VERSION_33

# Set default Ruby version
RUN asdf local ruby $ROD_RUBY_VERSION_33
RUN asdf list  ruby

# ############################################################################

#
# Python and PyPy runtime versions
#

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

# Python2 dependencies are hardcoded because Python2 is
# deprecated. Updating them to their latest versions may raise
# incompatibility issues.
RUN asdf local python $ROD_PYTHON_VERSION_27 && \
    pip install --upgrade pip==20.3.4 && \
    pip install --upgrade setuptools==44.1.1 && \
    pip install --upgrade virtualenv==20.15.1 && \
    pip install --upgrade wheel==0.37.1 && \
    pip install --upgrade poetry==1.1.15

# Install Python package versions
RUN asdf local python $ROD_PYTHON_VERSION_310 && \
    pip install --upgrade pip==$ROD_PIP_VERSION && \
    pip install --upgrade setuptools==$ROD_SETUPTOOLS_VERSION && \
    pip install --upgrade virtualenv==$ROD_VIRTUALENV_VERSION && \
    pip install --upgrade wheel==$ROD_WHEEL_VERSION && \
    pip install --upgrade poetry==$ROD_POETRY_VERSION && \
    pip install --upgrade west==$ROD_WEST_VERSION

RUN asdf local python $ROD_PYTHON_VERSION_312 && \
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
LABEL python.pip=$ROD_PIP_VERSION
LABEL python.setuptools=$ROD_SETUPTOOLS_VERSION
LABEL python.virtualenv=$ROD_VIRTUALENV_VERSION
LABEL python.wheel=$ROD_WHEEL_VERSION
LABEL python.poetry=$ROD_POETRY_VERSION
LABEL python.west=$ROD_WEST_VERSION

# Set default Python version
RUN asdf local python $ROD_PYTHON_VERSION_312
RUN asdf list  python

# ############################################################################
#
# All architectures maintenance
#
# ############################################################################

FROM build-${TARGETARCH} AS build

# ############################################################################

#
# PyPA pipx for Python runtime version
#

# Install pipx version
RUN asdf install pipx $ROD_PIPX_VERSION && \
    asdf global  pipx $ROD_PIPX_VERSION && \
    asdf reshim  pipx

# Adding labels for external usage
LABEL pipx.version=$ROD_PIPX_VERSION
LABEL pipx_argcomplete.version=$ROD_PIPX_ARGCOMPLETE_VERSION

# Set default pipx version
RUN asdf local pipx $ROD_PIPX_VERSION
RUN asdf list  pipx

# Ensure PATH environment variable for pipx
RUN pipx ensurepath

# Enabling shell completions for pipx
RUN pipx install argcomplete==$ROD_PIPX_ARGCOMPLETE_VERSION && \
    pipx pin     argcomplete && \
    echo 'eval "$(register-python-argcomplete pipx)"' >> /home/docs/.bashrc

# ############################################################################

# Install Python 3.12 package versions
RUN asdf local python $ROD_PYTHON_VERSION_312 && \
    pipx install --suffix=@$ROD_POETRY_VERSION_18 \
                   poetry==$ROD_POETRY_VERSION_18 && \
    pipx pin       poetry@$ROD_POETRY_VERSION_18 && \
    pipx install --suffix=@$ROD_POETRY_VERSION_17 \
                   poetry==$ROD_POETRY_VERSION_17 && \
    pipx pin       poetry@$ROD_POETRY_VERSION_17

# Install Python 3.10 package versions
RUN asdf local python $ROD_PYTHON_VERSION_310 && \
    pipx install --suffix=@$ROD_POETRY_VERSION_16 \
                   poetry==$ROD_POETRY_VERSION_16 && \
    pipx pin       poetry@$ROD_POETRY_VERSION_16 && \
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
LABEL python.poetry_18=$ROD_POETRY_VERSION_18
LABEL python.poetry_17=$ROD_POETRY_VERSION_17
LABEL python.poetry_16=$ROD_POETRY_VERSION_16
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
