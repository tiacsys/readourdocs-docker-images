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

- based on [Ubuntu official Docker image](
  https://github.com/docker-library/official-images),
  **ubuntu:noble-20240904.1**
  - Ubuntu 24.04.1 LTS
- extend with:
  - Ubuntu system package upgrade
  - locales for English unicode (`en_US.UTF-8`)
  - locales for German unicode (`de_DE.UTF-8`)
  - **Python 3.12.3** (`python3`, `pip3`)
  - **LLVM C/C++** compiler **18.1.3** (`clang`, `clang++`)
  - **GNU C/C++** compiler **13.2.0** (`gcc`, `g++`)
  - **GNU Fortran 95** compiler **13.2.0** (`gfortran`)
  - **OpenJDK 21** (`java`, `javac`)
  - **SWIG 4.2.0** (`swig`)
  - **TeX Live 2023** (`latex`, `xelatex`, `pdflatex`, `xindy`, `latexmk`)
  - **ImageMagick 6.9.12.98** (`convert`)
  - **Graphviz 2.43.0** (`dot`)
  - **PlantUML 1.2020.2** (`plantuml`)
  - **librsvg2-bin 2.58.0** (`rsvg-convert`)
  - **poppler-utils 24.02.0** (`pdf2svg`, `pdftocairo`)
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
    - **22.9.0**: `asdf local nodejs 22.9.0` (default)
    - **20.17.0**: `asdf global nodejs 20.17.0`
    - **18.20.4**: `asdf global nodejs 18.20.4`
  - **Ruby**:
    - **3.3.5**: `asdf local ruby 3.3.5` (default)
    - **3.2.5**: `asdf global ruby 3.2.5`
    - **3.1.6**: `asdf global ruby 3.1.6`
  - **Python**:
    - **3.12.7**: `asdf local python 3.12.7` (default)
    - 3.11.10: security until October 2027, (deprecated)
    - **3.10.15**: `asdf global python 3.10.15`
    - **pypy3.10-7.3.17**: `asdf global python pypy3.10-7.3.17`
    - 3.9.20: security until October 2025, (deprecated)
    - 3.8.20: security until October 2024, (deprecated)
    - 3.7.17: end-of-life since June 2023
    - 3.6.15: end-of-life since December 2021
    - 3.5.10: end-of-life since September 2020
    - 3.4.10: end-of-life since March 2019
    - 3.3.7: end-of-life since September 2017
    - 3.2.6: end-of-life since February 2016
    - 3.1.5: end-of-life since April 2012
    - 3.0.1: end-of-life since June 2009
    - **2.7.18**: `asdf global python 2.7.18` (obsolete)
    - **pypy2.7-7.3.17**: `asdf global python pypy2.7-7.3.17`
  - **PyPA pipx**:
    - **1.7.1**: `asdf local pipx 1.7.1` (default)
- Python packages:
  - `pip==24.2`
  - `setuptools==75.1.0`
  - `virtualenv==20.26.6`
  - `wheel==0.44.0`
  - `poetry==1.8.3`
  - `west==1.2.0`
  - only-binary: `numpy`, `scipy`, `pandas`, `matplotlib`
- PyPA pipx packages at Python 3.12:
  - **poetry@1.8.3**: `pipx install --suffix=@1.8.3 poetry==1.8.3`
  - **poetry@1.7.1**: `pipx install --suffix=@1.7.1 poetry==1.7.1`
- PyPA pipx packages at Python 3.10:
  - **poetry@1.6.1**: `pipx install --suffix=@1.6.1 poetry==1.6.1`
  - **poetry@1.5.1**: `pipx install --suffix=@1.5.1 poetry==1.5.1`
  - **poetry@1.4.2**: `pipx install --suffix=@1.4.2 poetry==1.4.2`
  - **poetry@1.3.2**: `pipx install --suffix=@1.3.2 poetry==1.3.2`
  - **poetry@1.2.2**: `pipx install --suffix=@1.2.2 poetry==1.2.2`
  - **poetry@1.1.15**: `pipx install --suffix=@1.1.15 poetry==1.1.15`
