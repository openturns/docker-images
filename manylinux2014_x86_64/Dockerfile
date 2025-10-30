FROM quay.io/pypa/manylinux2014_x86_64

ENV MAKEFLAGS=-j8
WORKDIR /usr/local/src

RUN yum install -y zlib-devel xz xz-devel pcre-devel zip wget bzip2-devel openssl-devel mpfr-devel libmpc-devel

# lapack
RUN curl -fsSL https://github.com/Reference-LAPACK/lapack/archive/v3.12.1.tar.gz | tar xz && cd lapack* && cmake -DLAPACKE=ON -DCBLAS=ON -DBUILD_TESTING=OFF -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON -B build . && make install -C build > /dev/null 2>&1 && cd .. && rm -r lapack*

# highs
RUN curl -fsSL https://github.com/ERGO-Code/HiGHS/archive/refs/tags/v1.12.0.tar.gz | tar xz && cd HiGHS* && cmake -DBUILD_CXX_EXE=OFF -DBUILD_EXAMPLES=OFF -DBUILD_TESTING=OFF -DCMAKE_UNITY_BUILD=ON -B build . && make install -C build > /dev/null 2>&1 && cd .. && rm -r HiGHS*

# ipopt
RUN curl -fsSL https://github.com/KarypisLab/GKlib/archive/refs/tags/METIS-v5.1.1-DistDGL-0.5.tar.gz | tar xz && cd GKlib-METIS* && curl -L https://github.com/KarypisLab/GKlib/commit/33b8c8bb.patch | patch -p1 && sed -i "/march=native/d" GKlibSystem.cmake && sed -i "s|VERSION 2.8|VERSION 3.5|g" CMakeLists.txt && cmake -DBUILD_SHARED_LIBS=ON . && make install > /dev/null 2>&1 && cd - && rm -r GKlib*
RUN curl -fsSL https://github.com/KarypisLab/METIS/archive/v5.2.1.tar.gz | tar xz && cd METIS* && mkdir -p build/xinclude && sed -i "s|//#define IDXTYPEWIDTH 32|#define IDXTYPEWIDTH 32|g" include/metis.h && sed -i "s|//#define REALTYPEWIDTH 32|#define REALTYPEWIDTH 64|g" include/metis.h && cp include/metis.h include/CMakeLists.txt build/xinclude && echo "target_link_libraries(metis GKlib)" >> libmetis/CMakeLists.txt && sed -i "/march=native/d" conf/gkbuild.cmake && sed -i "s|VERSION 2.8|VERSION 3.5|g" CMakeLists.txt && cmake -DSHARED=ON . && make install > /dev/null 2>&1 && cd - && rm -r METIS*
RUN curl -fsSL https://github.com/coin-or-tools/ThirdParty-Mumps/archive/releases/3.0.9.tar.gz | tar xz && cd ThirdParty-Mumps* && ./get.Mumps && FFLAGS="-O2 -fallow-argument-mismatch" ./configure --prefix=/usr/local && make -j1 > /dev/null 2>&1 && make install > /dev/null 2>&1 && cd - && rm -r ThirdParty*
RUN curl -fsSL https://github.com/coin-or/Ipopt/archive/releases/3.14.17.tar.gz | tar xz && cd Ipopt* && ./configure --prefix=/usr/local --without-hsl --disable-java && make > /dev/null 2>&1 && make install > /dev/null 2>&1 && cd - && rm -r Ipopt*

# bonmin
ENV BUILD=x86_64-unknown-linux-gnu
RUN curl -fsSL https://github.com/coin-or/CoinUtils/archive/refs/tags/releases/2.11.11.tar.gz | tar xz && cd CoinUtils* && ./configure --prefix=/usr/local --with-blas-lib='-lblas' --with-lapack-lib='-llapack' --enable-dependency-linking --build=${BUILD} && make > /dev/null 2>&1 && make install > /dev/null 2>&1 && cd - && rm -r CoinUtils*
RUN curl -fsSL https://github.com/coin-or/Osi/archive/refs/tags/releases/0.108.10.tar.gz | tar xz && cd Osi* && ./configure --prefix=/usr/local --build=${BUILD} && make > /dev/null 2>&1 && make install > /dev/null 2>&1 && cd - && rm -r Osi*
RUN curl -fsSL https://github.com/coin-or/Clp/archive/refs/tags/releases/1.17.10.tar.gz | tar xz && cd Clp* && ./configure --prefix=/usr/local --build=${BUILD} && make > /dev/null 2>&1 && make install > /dev/null 2>&1 && cd - && rm -r Clp*
RUN curl -fsSL https://github.com/coin-or/Cgl/archive/refs/tags/releases/0.60.9.tar.gz | tar xz && cd Cgl* && ./configure --prefix=/usr/local --build=${BUILD} && make > /dev/null 2>&1 && make install > /dev/null 2>&1 && cd - && rm -r Cgl*
RUN curl -fsSL https://github.com/coin-or/Cbc/archive/refs/tags/releases/2.10.12.tar.gz | tar xz && cd Cbc* && ./configure --prefix=/usr/local --build=${BUILD} && make > /dev/null 2>&1 && make install > /dev/null 2>&1 && cd - && rm -r Cbc*
RUN curl -fsSL https://github.com/coin-or/Bonmin/archive/refs/tags/releases/1.8.9.tar.gz | tar xz && cd Bonmin* && ./configure --prefix=/usr/local --with-ipopt-lib="$(pkg-config --libs ipopt)" --with-ipopt-incdir="/usr/local/include/coin-or/" --build=${BUILD} && make > /dev/null 2>&1 && make install > /dev/null 2>&1 && cd - && rm -r Bonmin*

# dlib
RUN curl -fSsL https://github.com/davisking/dlib/archive/v19.24.8.tar.gz | tar xz && cd dlib* \
 && mkdir build && cd build && cmake -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Release -DDLIB_NO_GUI_SUPPORT=ON -DUSE_AVX_INSTRUCTIONS=OFF -DDLIB_USE_CUDA=OFF -DDLIB_USE_FFMPEG=OFF -DDLIB_JPEG_SUPPORT=OFF -DDLIB_PNG_SUPPORT=OFF .. && make install > /dev/null 2>&1 && cd ../.. && rm -r dlib*

# cminpack
RUN curl -fsSL https://github.com/devernay/cminpack/archive/v1.3.10.tar.gz | tar xz && cd cminpack* \
 && cmake -DBUILD_SHARED_LIBS=ON -DBUILD_EXAMPLES=OFF -DCMINPACK_PRECISION=d . && make install > /dev/null 2>&1 && cd - && rm -r cminpack*

# eigen
RUN curl -fsSL https://gitlab.com/libeigen/eigen/-/archive/3.4.0/eigen-3.4.0.tar.bz2 | tar xj && cd eigen* \
 && mkdir build && cd build && cmake .. && make install > /dev/null 2>&1 && cd ../.. && rm -r eigen*

# spectra
RUN curl -fsSL https://github.com/yixuan/spectra/archive/v1.1.0.tar.gz | tar xz && cd spectra* && cmake . && make install > /dev/null 2>&1 && cd - && rm -r spectra*

# glog
RUN curl -fsSL https://github.com/google/glog/archive/v0.7.0.tar.gz | tar xz && cd glog* && cmake -DBUILD_TESTING=OFF . && make install > /dev/null 2>&1 && cd - && rm -r glog*

# ceres
RUN curl -fsSL https://github.com/ceres-solver/ceres-solver/archive/2.2.0.tar.gz | tar xz && cd ceres* \
 && cmake -DBUILD_SHARED_LIBS=ON -DGFLAGS=OFF . && make install > /dev/null 2>&1 && cd - && rm -r ceres*

# boost
ENV BOOST_ARCH=x86
RUN curl -fSsL https://archives.boost.io/release/1.87.0/source/boost_1_87_0.tar.bz2 | tar xj && cd boost* \
 && ./bootstrap.sh --with-toolset=gcc --with-icu --with-python=/usr/local/bin/python \
 && ./b2 -q variant=release address-model=64 architecture=${BOOST_ARCH} debug-symbols=off threading=multi runtime-link=shared link=shared toolset=gcc --layout=system ${MAKEFLAGS} install --with-serialization > /dev/null 2>&1 && cd - && rm -r boost*

# nlopt
RUN curl -fSsL https://github.com/stevengj/nlopt/archive/v2.10.0.tar.gz | tar xz && cd nlopt* && cmake . && make install > /dev/null 2>&1 && cd - && rm -r nlopt*

# tbb
RUN curl -fSsL https://github.com/oneapi-src/oneTBB/archive/refs/tags/v2022.0.0.tar.gz | tar xz && cd oneTBB* && cmake -DTBB_TEST=OFF . && make install > /dev/null 2>&1 && cd - && rm -r oneTBB*

# pagmo
RUN curl -fsSL https://github.com/esa/pagmo2/archive/refs/tags/v2.19.1.tar.gz | tar xz && cd pagmo* && cmake -DPAGMO_WITH_EIGEN3=ON -DCMAKE_UNITY_BUILD=ON . && make install > /dev/null 2>&1 && cd - && rm -r pagmo*

# libxml2
RUN curl -fsSL https://download.gnome.org/sources/libxml2/2.14/libxml2-2.14.1.tar.xz | tar xJ && cd libxml2* \
 && ./configure --without-python && make > /dev/null 2>&1 && make install > /dev/null 2>&1 && cd - && rm -r libxml2*

# hdf5
RUN curl -fsSL https://github.com/HDFGroup/hdf5/releases/download/hdf5_1.14.5/hdf5-1.14.5.tar.gz | tar xz && cd hdf5* && ./configure --enable-cxx --prefix=/usr/local --disable-tests --disable-tools --disable-static && make > /dev/null 2>&1 && make install > /dev/null 2>&1 && cd - && rm -r hdf5*

# fftw
RUN curl -fsSL http://www.fftw.org/fftw-3.3.10.tar.gz | tar xz && cd fftw* && ./configure --enable-shared --disable-static && make > /dev/null 2>&1 && make install > /dev/null 2>&1 && cd - && rm -r fftw*

# mixmod
RUN curl -fsSL https://github.com/mixmod/mixmod/archive/refs/tags/v2.1.11.tar.gz | tar xz && cd mixmod* && cmake -DCMAKE_UNITY_BUILD=ON . && make install > /dev/null 2>&1 && cd - && rm -r mixmod*

# primesieve
RUN curl -fsSL https://github.com/kimwalisch/primesieve/archive/v12.7.tar.gz | tar xz && cd primesieve* && cmake -DBUILD_STATIC_LIBS=OFF -DWITH_MULTIARCH=OFF -DBUILD_PRIMESIEVE=OFF . && make install > /dev/null 2>&1 && cd - && rm -r primesieve*

# nanoflann
RUN curl -fsSL https://github.com/jlblancoc/nanoflann/archive/refs/tags/v1.7.0.tar.gz | tar xz && cd nanoflann* && cmake -DNANOFLANN_BUILD_EXAMPLES=OFF -DNANOFLANN_BUILD_TESTS=OFF . && make install > /dev/null 2>&1 && cd - && rm -r nanoflann*

# cuba
RUN curl -fsSL https://feynarts.de/cuba/Cuba-4.2.2.tar.gz | tar xz && cd Cuba-4.2.2 && CFLAGS="-fPIC ${CFLAGS}" ./configure && make -j1 > /dev/null 2>&1 && make install -j1 > /dev/null 2>&1 && cd - && rm -r Cuba*
