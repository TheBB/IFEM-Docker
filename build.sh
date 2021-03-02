#!/bin/bash

build_petsc() {
    cd sources/petsc
    ./configure --with-cc=mpicc --with-cxx=mpicxx --with-fc=mpif90 --with-mpi --with-debugging=0 \
                --download-ml --download-hypre --download-mumps --download-scalapack \
                --COPTFLAGS="-O3 -g" --CXXOPTFLAGS="-O3 -g" --FOPTFLAGS="-O3 -g"
    make -j4
    cd /
}

build() {
    cd sources/$1
    shift
    mkdir build
    cd build
    cmake -Wno-dev "$@" ..
    make -j4
    make install
    cd /
}

build_petsc
build IFEM -DIFEM_INSTALL_DOXY=0 -DIFEM_USE_MPI=1 -DIFEM_USE_CEREAL=1
build IFEM-AdvectionDiffusion
build IFEM-Darcy
build IFEM-Elasticity/Linear
build IFEM-Elasticity/Shell
build IFEM-OpenFrac
build IFEM-Poisson
build IFEM-PoroElasticity
build IFEM-ThermoElasticity
