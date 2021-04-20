#!/bin/bash

build_petsc() {
    cd /sources/petsc
    ./configure --with-cc=mpicc --with-cxx=mpicxx --with-fc=mpif90 --with-mpi --with-debugging=0 \
                --download-ml --download-hypre --download-mumps --download-scalapack \
                --COPTFLAGS="-O3 -g" --CXXOPTFLAGS="-O3 -g" --FOPTFLAGS="-O3 -g"
    make -j4
}

build_siso() {
    cd /sources/siso
    pip3 install .
}

build_ifem() {
    cd /sources/$1
    shift
    mkdir build
    cd build
    cmake -Wno-dev "$@" ..
    make -j4
    make install
}

build_petsc
build_siso
build_ifem IFEM -DIFEM_INSTALL_DOXY=0 -DIFEM_USE_MPI=1 -DIFEM_USE_CEREAL=1 -DIFEM_USE_ZOLTAN=1
build_ifem IFEM-AdvectionDiffusion
build_ifem IFEM-Darcy
build_ifem IFEM-Elasticity/Linear
build_ifem IFEM-Elasticity/Shell
build_ifem IFEM-OpenFrac
build_ifem IFEM-Poisson
build_ifem IFEM-PoroElasticity
build_ifem IFEM-ThermoElasticity
