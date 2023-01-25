
FROM quay.io/pypa/manylinux2014_x86_64
MAINTAINER jschueller

ENV MAKEFLAGS -j8
WORKDIR /usr/local/src

RUN yum install -y zlib-devel xz xz-devel pcre-devel zip wget bzip2-devel openssl-devel mpfr-devel libmpc-devel

# bison/flex
RUN curl -fsSL https://ftp.gnu.org/gnu/bison/bison-3.8.2.tar.gz | tar xz && cd bison-3.8.2 && ./configure && make > /dev/null 2>&1 && make install > /dev/null 2>&1 && cd - && rm -r bison*
RUN curl -fsSL https://github.com/westes/flex/releases/download/v2.6.4/flex-2.6.4.tar.gz | tar xz && cd flex-2.6.4 && ./configure && make > /dev/null 2>&1 && make install > /dev/null 2>&1  && cd - && rm -r flex*

# lapack
RUN curl -fsSL https://github.com/Reference-LAPACK/lapack/archive/v3.11.0.tar.gz | tar xz && cd lapack-3.11.0 && mkdir build && cd build && cmake -DLAPACKE=ON -DCBLAS=ON -DBUILD_TESTING=OFF -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON .. && make install > /dev/null 2>&1 && cd ../.. && rm -r lapack*

# hmat
RUN curl -fsSL https://github.com/jeromerobert/hmat-oss/archive/1.8.1.tar.gz | tar xz && cd hmat-oss-1.8.1 && cmake . && make install > /dev/null 2>&1 && cd - && rm -r hmat*

# ipopt
RUN curl -fsSL https://bitbucket.org/petsc/pkg-metis/get/v5.1.0-p10.tar.bz2 | tar xj && cd petsc-pkg-metis-* && make config shared=1 > /dev/null 2>&1 && make install > /dev/null 2>&1 && cd - && rm -r petsc*
RUN curl -fsSL https://github.com/coin-or-tools/ThirdParty-Mumps/archive/releases/1.6.2.tar.gz | tar xz && cd ThirdParty-Mumps-releases-1.6.2 && ./get.Mumps && FFLAGS="-O2 -fallow-argument-mismatch" ./configure --prefix=/usr/local && make > /dev/null 2>&1 && make install > /dev/null 2>&1 && cd - && rm -r ThirdParty*
RUN curl -fsSL https://github.com/coin-or/Ipopt/archive/releases/3.14.10.tar.gz | tar xz && cd Ipopt-releases-3.14.10 && ./configure --prefix=/usr/local --without-hsl --disable-java && make > /dev/null 2>&1 && make install > /dev/null 2>&1 && cd - && rm -r Ipopt*

# bonmin
RUN curl -fsSL https://www.coin-or.org/download/source/Bonmin/Bonmin-1.8.8.tgz | tar xz && cd Bonmin-1.8.8 && ./configure --prefix=/usr/local --with-ipopt-lib="$(pkg-config --libs ipopt)" --with-ipopt-incdir="/usr/local/include/coin-or/" && make > /dev/null 2>&1 && make install > /dev/null 2>&1 && cd - && rm -r Bonmin*

# dlib
RUN curl -fSsL https://github.com/davisking/dlib/archive/v19.24.tar.gz | tar xz && cd dlib-19.24 \
 && mkdir build && cd build && cmake -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Release -DDLIB_NO_GUI_SUPPORT=ON .. && make install > /dev/null 2>&1 && cd ../.. && rm -r dlib*

# cminpack
RUN curl -fsSL https://github.com/devernay/cminpack/archive/v1.3.8.tar.gz | tar xz && cd cminpack-1.3.8 \
 && cmake -DBUILD_SHARED_LIBS=ON -DBUILD_EXAMPLES=OFF -DCMINPACK_PRECISION=d . && make install > /dev/null 2>&1 && cd - && rm -r cminpack*

# eigen
RUN curl -fsSL https://gitlab.com/libeigen/eigen/-/archive/3.4.0/eigen-3.4.0.tar.bz2 | tar xj && cd eigen-3.4.0 \
 && mkdir build && cd build && cmake .. && make install > /dev/null 2>&1 && cd ../.. && rm -r eigen*

# spectra
RUN curl -fsSL https://github.com/yixuan/spectra/archive/v1.0.1.tar.gz | tar xz && cd spectra-1.0.1 && cmake . && make install > /dev/null 2>&1 && cd - && rm -r spectra*

# glog
RUN curl -fsSL https://github.com/google/glog/archive/v0.6.0.tar.gz | tar xz && cd glog-0.6.0 && cmake -DBUILD_TESTING=OFF . && make install > /dev/null 2>&1 && cd - && rm -r glog*

# ceres
RUN curl -fsSL https://github.com/ceres-solver/ceres-solver/archive/2.1.0.tar.gz | tar xz && cd ceres-solver-2.1.0 \
 && cmake -DBUILD_SHARED_LIBS=ON -DGFLAGS=OFF . && make install > /dev/null 2>&1 && cd - && rm -r ceres*

# boost
RUN curl -fSsL https://boostorg.jfrog.io/artifactory/main/release/1.81.0/source/boost_1_81_0.tar.bz2 | tar xj && cd boost_1_81_0 \
 && ./bootstrap.sh --with-toolset=gcc --with-icu --with-python=/usr/local/bin/python \
 && ./b2 -q variant=release address-model=64 architecture=x86 debug-symbols=off threading=multi runtime-link=shared link=shared toolset=gcc --layout=system ${MAKEFLAGS} install --with-serialization && cd - && rm -r boost*

# nlopt
RUN curl -fSsL https://github.com/stevengj/nlopt/archive/v2.7.1.tar.gz | tar xz && cd nlopt-2.7.1 \
 && cmake . && make install > /dev/null 2>&1 && cd - && rm -r nlopt*

# tbb
RUN curl -fSsL https://github.com/oneapi-src/oneTBB/archive/refs/tags/v2021.7.0.tar.gz | tar xz && cd oneTBB-2021.7.0 && cmake -DTBB_TEST=OFF . && make install > /dev/null 2>&1 && cd - && rm -r oneTBB*

# pagmo
RUN curl -fsSL https://github.com/esa/pagmo2/archive/refs/tags/v2.19.0.tar.gz | tar xz && cd pagmo2-2.19.0 && cmake -DPAGMO_WITH_EIGEN3=ON . && make install > /dev/null 2>&1 && cd - && rm -r pagmo*

# libxml2
RUN curl -fsSL https://download.gnome.org/sources/libxml2/2.10/libxml2-2.10.3.tar.xz | tar xJ && cd libxml2-2.10.3 \
 && ./configure --without-python && make > /dev/null 2>&1 && make install > /dev/null 2>&1 && cd - && rm -r libxml2*

# hdf5
RUN curl -fsSL https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.12/hdf5-1.12.2/src/hdf5-1.12.2.tar.bz2 | tar xj && cd hdf5-1.12.2 && ./configure --enable-cxx --prefix=/usr/local --disable-tests --disable-tools && make > /dev/null 2>&1 && make install > /dev/null 2>&1 && cd - && rm -r hdf5*

# fftw
RUN curl -fsSL http://www.fftw.org/fftw-3.3.10.tar.gz | tar xz && cd fftw-3.3.10 && ./configure --enable-shared --disable-static && make > /dev/null 2>&1 && make install > /dev/null 2>&1 && cd - && rm -r fftw*

# primesieve
RUN curl -fsSL https://github.com/kimwalisch/primesieve/archive/v11.0.tar.gz | tar xz && cd primesieve-11.0 && cmake -DBUILD_STATIC_LIBS=OFF -DWITH_MULTIARCH=OFF . && make install > /dev/null 2>&1 && cd - && rm -r primesieve*
