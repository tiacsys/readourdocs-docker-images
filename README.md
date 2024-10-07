# Read-Our-Docs (ROD) Docker Image

## Description

This project creates the full-stack and multi-arch Docker images for processing
[tutorial](https://bridle.tiac-systems.net/tutorials) and
[training](https://bridle.tiac-systems.net/trainings) materials.

## Canonical source

The source of the ROD Docker Image is [hosted on https://github.com/tiacsys](
https://github.com/tiacsys/readourdocs-docker-images).

## Documentation

The documentation overview is in this [readme in the project root directory](
README.md).

## Content

Based on [Ubuntu official Docker image](
https://github.com/docker-library/official-images),
**ubuntu:noble-20240904.1**:

- [Ubuntu](https://hub.docker.com/_/ubuntu) 24.04.1 LTS
- Docker image architectures:
  - Linux x86-64 (`linux/amd64`): https://hub.docker.com/r/amd64/ubuntu
  - ARMv7 32-bit (`linux/arm/v7`): https://hub.docker.com/r/arm32v7/ubuntu
  - ARMv8 64-bit (`linux/arm64`): https://hub.docker.com/r/arm64v8/ubuntu
  - RISC-V 64-bit (`linux/riscv64`): https://hub.docker.com/r/riscv64/ubuntu

### Ubuntu system packages

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

### Multiple runtime environments

Based on [**asdf**](https://asdf-vm.com/) **0.14.1**:

| runtime environments | environment variable      | `linux/amd64` | `linux/arm/v7` | `linux/arm64` | `linux/riscv64` |
| :------------------- | :------------------------ | :---: | :---: | :---: | :---: |
| **Rust 1.81.0**      | `ROD_RUST_VERSION_2024`   | **X** | **X** | **X** | **X** |
|   Rust 1.76.0        | `ROD_RUST_VERSION_2023`   |   X   |       |       |       |
|   Rust 1.67.1        | `ROD_RUST_VERSION_2022`   |   X   |       |       |       |
| **Golang 1.23.1**    | `ROD_GOLANG_VERSION_2024` | **X** | **X** | **X** | **X** |
|   Golang 1.21.13     | `ROD_GOLANG_VERSION_2023` |   X   |       |       |       |
|   Golang 1.19.13     | `ROD_GOLANG_VERSION_2022` |   X   |       |       |       |
| **Node.js 22.9.0**   | `ROD_NODEJS_VERSION_22`   | **X** | **X** | **X** |       |
|   Node.js 20.17.0    | `ROD_NODEJS_VERSION_20`   |   X   |       |       |       |
|   Node.js 18.20.4    | `ROD_NODEJS_VERSION_18`   |   X   |       |       |       |
| **Ruby 3.3.5**       | `ROD_RUBY_VERSION_33`     | **X** | **X** | **X** | **X** |
|   Ruby 3.2.5         | `ROD_RUBY_VERSION_32`     |   X   |       |       |       |
|   Ruby 3.1.6         | `ROD_RUBY_VERSION_31`     |   X   |       |       |       |
| **Python 3.12.7**    | `ROD_PYTHON_VERSION_312`  | **X** | **X** | **X** | **X** |
|   Python 3.10.15     | `ROD_PYTHON_VERSION_310`  |   X   |   X   |   X   |   X   |
|   Python 2.7.18      | `ROD_PYTHON_VERSION_27`   |   X   |   X   |   X   |   X   |
|   PyPy 3.10-7.3.17   | `ROD_PYPY_VERSION_3`      |   X   |       |       |       |
|   PyPy 2.7-7.3.17    | `ROD_PYPY_VERSION_2`      |   X   |       |       |       |
| **PyPA pipx 1.7.1**  | `ROD_PIPX_VERSION`        | **X** | **X** | **X** | **X** |

**bold**: default runtime environment

The build of Node.js from source code fails on `linux/riscv64`!

### Python 3 packages

Based on [Python Package Index](https://pypi.org/) with pip:

| PyPI package name      | environment variable      | `linux/amd64` | `linux/arm/v7` | `linux/arm64` | `linux/riscv64` |
| :--------------------- | :------------------------ | :---: | :---: | :---: | :---: |
| `pip==24.2`            | `ROD_PIP_VERSION`         |   X   |   X   |   X   |   X   |
| `setuptools==75.1.0`   | `ROD_SETUPTOOLS_VERSION`  |   X   |   X   |   X   |   X   |
| `virtualenv==20.26.6`  | `ROD_VIRTUALENV_VERSION`  |   X   |   X   |   X   |   X   |
| `wheel==0.44.0`        | `ROD_WHEEL_VERSION`       |   X   |   X   |   X   |   X   |
| `poetry==1.8.3`        | `ROD_POETRY_VERSION`      |   X   |   X   |   X   |   X   |
| `west==1.2.0`          | `ROD_WEST_VERSION`        |   X   |   X   |   X   |   X   |
| `numpy`                |                           | *(X)* |       |       |       |
| `scipy`                |                           | *(X)* |       |       |       |
| `pandas`               |                           | *(X)* |       |       |       |
| `matplotlib`           |                           | *(X)* |       |       |       |

*(X)*: binary only and not in PyPy (CPython only)

### Python 2 packages (obsolete)

Based on [Python Package Index](https://pypi.org/) with pip:

| PyPI package name      | `linux/amd64` | `linux/arm/v7` | `linux/arm64` | `linux/riscv64` |
| :--------------------- | :---: | :---: | :---: | :---: |
| `pip==20.3.4`          |   X   |   X   |   X   |   X   |
| `setuptools==44.1.1`   |   X   |   X   |   X   |   X   |
| `virtualenv==20.15.1`  |   X   |   X   |   X   |   X   |
| `wheel==0.37.1`        |   X   |   X   |   X   |   X   |
| `poetry==1.1.15`       |   X   |   X   |   X   |   X   |
| `numpy==1.16.6`        | *(X)* |       |       |       |
| `scipy==1.2.3`         | *(X)* |       |       |       |
| `pandas==0.24.2`       | *(X)* |       |       |       |
| `matplotlib==2.2.5`    | *(X)* |       |       |       |

*(X)*: binary only and not in PyPy (CPython only)

### PyPA pipx packages

- PyPA pipx packages at Python 3.12:
  - **argcomplete**: `pipx install argcomplete==3.5.0`
  - **poetry@1.8.3**: `pipx install --suffix=@1.8.3 poetry==1.8.3`
  - **poetry@1.7.1**: `pipx install --suffix=@1.7.1 poetry==1.7.1`
- PyPA pipx packages at Python 3.10:
  - **poetry@1.6.1**: `pipx install --suffix=@1.6.1 poetry==1.6.1`
  - **poetry@1.5.1**: `pipx install --suffix=@1.5.1 poetry==1.5.1`
  - **poetry@1.4.2**: `pipx install --suffix=@1.4.2 poetry==1.4.2`
  - **poetry@1.3.2**: `pipx install --suffix=@1.3.2 poetry==1.3.2`
  - **poetry@1.2.2**: `pipx install --suffix=@1.2.2 poetry==1.2.2`
  - **poetry@1.1.15**: `pipx install --suffix=@1.1.15 poetry==1.1.15`
