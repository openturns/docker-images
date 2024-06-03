
FROM quay.io/pypa/manylinux2014_x86_64
MAINTAINER jschueller

ENV MAKEFLAGS -j8
WORKDIR /usr/local/src

RUN yum install -y zlib-devel xz xz-devel pcre-devel zip wget bzip2-devel openssl-devel mpfr-devel libmpc-devel

# bison/flex
RUN curl -fsSL https://ftp.gnu.org/gnu/bison/bison-3.8.2.tar.gz | tar xz && cd bison-3.8.2 && ./configure && make > /dev/null 2>&1 && make install > /dev/null 2>&1 && cd - && rm -r bison*
RUN curl -fsSL https://github.com/westes/flex/releases/download/v2.6.4/flex-2.6.4.tar.gz | tar xz && cd flex-2.6.4 && ./configure && make > /dev/null 2>&1 && make install > /dev/null 2>&1  && cd - && rm -r flex*

# lapack
RUN curl -fsSL https://github.com/Reference-LAPACK/lapack/archive/v3.12.0.tar.gz | tar xz && cd lapack-3.12.0 && mkdir build && cd build && cmake -DLAPACKE=ON -DCBLAS=ON -DBUILD_TESTING=OFF -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON .. && make install > /dev/null 2>&1 && cd ../.. && rm -r lapack*

# ipopt
RUN curl -fsSL https://github.com/KarypisLab/GKlib/archive/refs/tags/METIS-v5.1.1-DistDGL-0.5.tar.gz | tar xz && cd GKlib-METIS-v5.1.1-DistDGL-0.5 && curl -L https://github.com/KarypisLab/GKlib/commit/33b8c8bb.patch | patch -p1 && sed -i "s|march=native|march=nocona|g" GKlibSystem.cmake && cmake -DBUILD_SHARED_LIBS=ON . && make install > /dev/null 2>&1 && cd - && rm -r GKlib*
RUN curl -fsSL https://github.com/KarypisLab/METIS/archive/v5.2.1.tar.gz | tar xz && cd METIS-5.2.1 && mkdir -p build/xinclude && sed -i "s|//#define IDXTYPEWIDTH 32|#define IDXTYPEWIDTH 32|g" include/metis.h && sed -i "s|//#define REALTYPEWIDTH 32|#define REALTYPEWIDTH 64|g" include/metis.h && cp include/metis.h include/CMakeLists.txt build/xinclude && echo "target_link_libraries(metis GKlib)" >> libmetis/CMakeLists.txt && sed -i "s|march=native|march=nocona|g" conf/gkbuild.cmake && cmake -DSHARED=ON . && make install > /dev/null 2>&1 && cd - && rm -r METIS*
RUN curl -fsSL https://github.com/coin-or-tools/ThirdParty-Mumps/archive/releases/3.0.7.tar.gz | tar xz && cd ThirdParty-Mumps-releases-3.0.7 && ./get.Mumps && FFLAGS="-O2 -fallow-argument-mismatch" ./configure --prefix=/usr/local && make -j1 > /dev/null 2>&1 && make install > /dev/null 2>&1 && cd - && rm -r ThirdParty*
RUN curl -fsSL https://github.com/coin-or/Ipopt/archive/releases/3.14.16.tar.gz | tar xz && cd Ipopt-releases-3.14.16 && ./configure --prefix=/usr/local --without-hsl --disable-java && make > /dev/null 2>&1 && make install > /dev/null 2>&1 && cd - && rm -r Ipopt*

# bonmin
RUN curl -fsSL https://github.com/coin-or/CoinUtils/archive/refs/tags/releases/2.11.10.tar.gz | tar xz && cd CoinUtils-releases-2.11.10 && ./configure --prefix=/usr/local --with-blas-lib='-lblas' --with-lapack-lib='-llapack' --enable-dependency-linking && make > /dev/null 2>&1 && make install > /dev/null 2>&1 && cd - && rm -r CoinUtils*
RUN curl -fsSL https://github.com/coin-or/Osi/archive/refs/tags/releases/0.108.9.tar.gz | tar xz && cd Osi-releases-0.108.9 && ./configure --prefix=/usr/local && make > /dev/null 2>&1 && make install > /dev/null 2>&1 && cd - && rm -r Osi*
RUN curl -fsSL https://github.com/coin-or/Clp/archive/refs/tags/releases/1.17.9.tar.gz | tar xz && cd Clp-releases-1.17.9 && ./configure --prefix=/usr/local && make > /dev/null 2>&1 && make install > /dev/null 2>&1 && cd - && rm -r Clp*
RUN curl -fsSL https://github.com/coin-or/Cgl/archive/refs/tags/releases/0.60.8.tar.gz | tar xz && cd Cgl-releases-0.60.8 && ./configure --prefix=/usr/local && make > /dev/null 2>&1 && make install > /dev/null 2>&1 && cd - && rm -r Cgl*
RUN curl -fsSL https://github.com/coin-or/Cbc/archive/refs/tags/releases/2.10.11.tar.gz | tar xz && cd Cbc-releases-2.10.11 && ./configure --prefix=/usr/local && make > /dev/null 2>&1 && make install > /dev/null 2>&1 && cd - && rm -r Cbc*
RUN curl -fsSL https://github.com/coin-or/Bonmin/archive/refs/tags/releases/1.8.9.tar.gz | tar xz && cd Bonmin-releases-1.8.9 && ./configure --prefix=/usr/local --with-ipopt-lib="$(pkg-config --libs ipopt)" --with-ipopt-incdir="/usr/local/include/coin-or/" && make > /dev/null 2>&1 && make install > /dev/null 2>&1 && cd - && rm -r Bonmin*

# dlib
RUN curl -fSsL https://github.com/davisking/dlib/archive/v19.24.tar.gz | tar xz && cd dlib-19.24 \
 && mkdir build && cd build && cmake -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Release -DDLIB_NO_GUI_SUPPORT=ON .. && make install > /dev/null 2>&1 && cd ../.. && rm -r dlib*

# cminpack
RUN curl -fsSL https://github.com/devernay/cminpack/archive/v1.3.9.tar.gz | tar xz && cd cminpack-1.3.9 \
 && cmake -DBUILD_SHARED_LIBS=ON -DBUILD_EXAMPLES=OFF -DCMINPACK_PRECISION=d -DUSE_BLAS=OFF . && make install > /dev/null 2>&1 && cd - && rm -r cminpack*

# eigen
RUN curl -fsSL https://gitlab.com/libeigen/eigen/-/archive/3.4.0/eigen-3.4.0.tar.bz2 | tar xj && cd eigen-3.4.0 \
 && mkdir build && cd build && cmake .. && make install > /dev/null 2>&1 && cd ../.. && rm -r eigen*

# spectra
RUN curl -fsSL https://github.com/yixuan/spectra/archive/v1.0.1.tar.gz | tar xz && cd spectra-1.0.1 && cmake . && make install > /dev/null 2>&1 && cd - && rm -r spectra*

# glog
RUN curl -fsSL https://github.com/google/glog/archive/v0.7.0.tar.gz | tar xz && cd glog-0.7.0 && cmake -DBUILD_TESTING=OFF . && make install > /dev/null 2>&1 && cd - && rm -r glog*

# ceres
RUN curl -fsSL https://github.com/ceres-solver/ceres-solver/archive/2.2.0.tar.gz | tar xz && cd ceres-solver-2.2.0 \
 && cmake -DBUILD_SHARED_LIBS=ON -DGFLAGS=OFF . && make install > /dev/null 2>&1 && cd - && rm -r ceres*

# boost
RUN curl -fSsL https://boostorg.jfrog.io/artifactory/main/release/1.84.0/source/boost_1_84_0.tar.bz2 | tar xj && cd boost_1_84_0 \
 && ./bootstrap.sh --with-toolset=gcc --with-icu --with-python=/usr/local/bin/python \
 && ./b2 -q variant=release address-model=64 architecture=x86 debug-symbols=off threading=multi runtime-link=shared link=shared toolset=gcc --layout=system ${MAKEFLAGS} install --with-serialization > /dev/null 2>&1 && cd - && rm -r boost*

# nlopt
RUN curl -fSsL https://github.com/stevengj/nlopt/archive/v2.7.1.tar.gz | tar xz && cd nlopt-2.7.1 && cmake . && make install > /dev/null 2>&1 && cd - && rm -r nlopt*

# tbb
RUN curl -fSsL https://github.com/oneapi-src/oneTBB/archive/refs/tags/v2021.11.0.tar.gz | tar xz && cd oneTBB-2021.11.0 && cmake -DTBB_TEST=OFF . && make install > /dev/null 2>&1 && cd - && rm -r oneTBB*

# pagmo
RUN curl -fsSL https://github.com/esa/pagmo2/archive/refs/tags/v2.19.0.tar.gz | tar xz && cd pagmo2-2.19.0 && cmake -DPAGMO_WITH_EIGEN3=ON . && make install > /dev/null 2>&1 && cd - && rm -r pagmo*

# libxml2
RUN curl -fsSL https://download.gnome.org/sources/libxml2/2.12/libxml2-2.12.7.tar.xz | tar xJ && cd libxml2-2.12.7 \
 && ./configure --without-python && make > /dev/null 2>&1 && make install > /dev/null 2>&1 && cd - && rm -r libxml2*

# hdf5
RUN curl -fsSL https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.14/hdf5-1.14.3/src/hdf5-1.14.3.tar.bz2 | tar xj && cd hdf5-1.14.3 && ./configure --enable-cxx --prefix=/usr/local --disable-tests --disable-tools --disable-static && make > /dev/null 2>&1 && make install > /dev/null 2>&1 && cd - && rm -r hdf5*

# fftw
RUN curl -fsSL http://www.fftw.org/fftw-3.3.10.tar.gz | tar xz && cd fftw-3.3.10 && ./configure --enable-shared --disable-static && make > /dev/null 2>&1 && make install > /dev/null 2>&1 && cd - && rm -r fftw*

# mixmod
RUN curl -fsSL https://github.com/mixmod/mixmod/archive/refs/tags/v2.1.10.tar.gz | tar xz && cd mixmod-2.1.10 && cmake -DCMAKE_UNITY_BUILD=ON . && make install > /dev/null 2>&1 && cd - && rm -r mixmod*

# primesieve
RUN curl -fsSL https://github.com/kimwalisch/primesieve/archive/v12.3.tar.gz | tar xz && cd primesieve-12.3 && cmake -DBUILD_STATIC_LIBS=OFF -DWITH_MULTIARCH=OFF -DBUILD_PRIMESIEVE=OFF . && make install > /dev/null 2>&1 && cd - && rm -r primesieve*

# nanoflann
RUN curl -fsSL https://github.com/jlblancoc/nanoflann/archive/refs/tags/v1.5.5.tar.gz | tar xz && cd nanoflann-1.5.5 && cmake -DNANOFLANN_BUILD_EXAMPLES=OFF -DNANOFLANN_BUILD_TESTS=OFF . && make install > /dev/null 2>&1 && cd - && rm -r nanoflann*

# cuba
RUN curl -fsSL https://feynarts.de/cuba/Cuba-4.2.2.tar.gz | tar xz && cd Cuba-4.2.2 && CFLAGS="-fPIC ${CFLAGS}" ./configure && make -j1 > /dev/null 2>&1 && make install -j1 > /dev/null 2>&1 && cd - && rm -r Cuba*
