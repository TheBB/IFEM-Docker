FROM ubuntu

# Avoid some warnings when installing packages
ARG DEBIAN_FRONTEND=noninteractive

# We're running as root, must convince OpenMPI that it's fine
ENV OMPI_ALLOW_RUN_AS_ROOT=1
ENV OMPI_ALLOW_RUN_AS_ROOT_CONFIRM=1

# PETSc location
ENV PETSC_ARCH=parallel
ENV PETSC_DIR=/sources/petsc
ENV LD_LIBRARY_PATH=/sources/petsc/parallel/lib

RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:ifem/ppa
RUN apt-get update

RUN apt-get install -y \
    gcc g++ gfortran make cmake doxygen graphviz git python3-distutils pkg-config \
    libgotools-core-dev libgotools-trivariate-dev liblrspline-dev \
    libatlas-base-dev libarpack2-dev libsuperlu-dev \
    libopenmpi-dev libtrilinos-zoltan-dev libtinyxml-dev libcereal-dev \
    libdune-istl-dev libdune-common-dev libsuitesparse-dev \
    libhdf5-mpi-dev

COPY submodules /sources
COPY build.sh /build.sh

RUN git clone -b release https://gitlab.com/petsc/petsc.git sources/petsc
RUN /build.sh
