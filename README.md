# Read-Our-Docs (ROD) Docker Image

## Description

This project creates the full-stack Docker image for processing [tutorial](
https://bridle.tiac-systems.net/tutorials) and [training](
https://bridle.tiac-systems.net/trainings) materials.

## Canonical source

The source of the ROD Docker Image is [hosted on https://github.com/tiacsys](
https://github.com/tiacsys/readourdocs-docker-images).

## Documentation

The documentation overview is in this [readme in the project root directory](
README.md).

## Content

- based on [Docker image definitions used by Read the
  Docs](https://github.com/readthedocs/readthedocs-docker-images),
  **ubuntu-22.04-2024.01.29**
  - Ubuntu 22.04
  - TeX Live 2021
- extend with:
  - Ubuntu 22.04 package upgrade
  - locales for English unicode (`en_US.UTF-8`)
  - locales for German unicode (`de_DE.UTF-8`)
  - **Python 3.10.12** (`python3`, `pip3`)
  - **LLVM C/C++** compiler **14.0** (`clang`, `clang++`)
  - **GNU C/C++** compiler **11.4.0** (`gcc`, `g++`)
  - **GNU Fortran 95** compiler **11.4.0** (`gfortran`)
  - **OpenJDK 11** (`java`, `javac`)
  - **SWIG 4.0.2** (`swig`)
  - **TeX Live 2022** (`latex`, `xelatex`, `pdflatex`, `xindy`, `latexmk`)
  - **ImageMagick 6.9.11.60** (`convert`)
  - **Graphviz 2.43.0** (`dot`)
  - **PlantUML 1.2020.2** (`plantuml`)
  - **librsvg2-bin 2.52.5** (`rsvg-convert`)
  - **poppler-utils 22.02.0** (`pdf2svg`, `pdftocairo`)
- extend with asdf:
  - **Rust**:
    - **1.81.0**: `asdf local rust 1.81.0` (default)
    - **1.76.0**: `asdf global rust 1.76.0`
    - **1.67.1**: `asdf global rust 1.67.1`
  - **Golang**:
    - **1.23.1**: `asdf local golang 1.23.1` (default)
    - **1.21.13**: `asdf global golang 1.21.13`
    - **1.19.13**: `asdf global golang 1.19.13`
  - **Nodejs**:
    - **20.17.0**: `asdf local nodejs 20.17.0` (default)
    - **18.20.4**: `asdf global nodejs 18.20.4`
  - **Python**:
    - **3.10.9**: `asdf local python 3.10.9` (default)
- not yet add with asdf:
  - **Python**:
    - 2.7.18: `asdf local python 2.7.18` (obsolete)
    - 3.6.15: `asdf local python 3.6.15` (deprecated)
    - 3.7.16: `asdf local python 3.7.16`
    - 3.8.16: `asdf local python 3.8.16`
    - 3.9.16: `asdf local python 3.9.16`
    - 3.11.1: `asdf local python 3.11.1`
    - pypy3.7-7.3.9: `asdf local python pypy3.7-7.3.9`
    - pypy3.8-7.3.10: `asdf local python pypy3.8-7.3.10`
    - pypy3.9-7.3.10: `asdf local python pypy3.9-7.3.10`
    - anaconda3-2022.10: `asdf local python anaconda3-2022.10` (22.11.1)
    - miniconda3-4.7.12: `asdf local python miniconda3-4.7.12` (22.11.1)
    - miniforge3-22.9.0-2: `asdf local python miniforge3-22.9.0-2` (22.11.1)
    - miniforge-pypy3: `asdf local python miniforge-pypy3` (22.11.1)
    - mambaforge-22.9.0-2: `asdf local python mambaforge-22.9.0-2` (22.11.1)
    - mambaforge-pypy3: `asdf local python mambaforge-pypy3` (22.11.1)
  - Python packages:
    - pip, setuptools, virtualenv, wheel, poetry, west
    - numpy, scipy, pandas, matplotlib
