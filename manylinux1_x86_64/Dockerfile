
FROM quay.io/pypa/manylinux1_x86_64:latest
MAINTAINER jschueller

ENV MAKEFLAGS -j8
WORKDIR /usr/local/src

RUN yum install -y zlib-devel xz-devel pcre-devel zip wget bzip2-devel openssl-devel

# bison/flex
RUN curl -fsSL https://ftp.gnu.org/gnu/bison/bison-3.7.4.tar.gz | tar xz && cd bison-3.7.4 && ./configure && make && make install && cd - && rm -r bison*
RUN curl -fsSL https://github.com/westes/flex/releases/download/v2.6.4/flex-2.6.4.tar.gz | tar xz && cd flex-2.6.4 && ./configure && make && make install && cd - && rm -r flex*

# libuv
RUN curl -fsSL https://github.com/libuv/libuv/archive/v1.23.0.tar.gz | tar xz && cd libuv-1.23.0 \
 && ./autogen.sh && ./configure --prefix=/usr --libdir=/usr/lib64 --disable-static && make && make install && cd - && rm -r libuv*

# cmake
RUN curl -fsSL https://cmake.org/files/v3.20/cmake-3.20.1.tar.gz | tar xz && cd cmake-3.20.1 \
 && ./bootstrap --parallel=8 --bootstrap-system-libuv -- -DCMAKE_USE_SYSTEM_LIBRARY_LIBUV=ON . && make install && cmake --version && cd - && rm -r cmake*

# lapack
RUN curl -fsSL https://github.com/Reference-LAPACK/lapack/archive/v3.9.1.tar.gz | tar xz && cd lapack-3.9.1 && mkdir build && cd build && cmake -DLAPACKE=ON -DCBLAS=ON -DBUILD_TESTING=OFF -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON .. && make install && cd - && rm -r lapack*

# hmat
RUN curl -fsSL https://github.com/jeromerobert/hmat-oss/archive/1.6.1.tar.gz | tar xz && cd hmat-oss-1.6.1 && cmake . && make install && cd - && rm -r hmat*

# ipopt
RUN curl -fsSL https://bitbucket.org/petsc/pkg-metis/get/v5.1.0-p10.tar.bz2 | tar xj && cd petsc-pkg-metis-* && make config shared=1 && make install && cd - && rm -r petsc*
RUN curl -fsSL https://github.com/coin-or-tools/ThirdParty-Mumps/archive/releases/1.6.2.tar.gz | tar xz && cd ThirdParty-Mumps-releases-1.6.2 && ./get.Mumps && ./configure --prefix=/usr/local && make && make install && cd - && rm -r ThirdParty*
RUN curl -fsSL http://www.coin-or.org/download/source/Ipopt/Ipopt-3.14.2.tar.gz | tar xz && cd Ipopt-releases-3.14.2 && sed -i "s|static IPOPT_THREAD_LOCAL|static|g" src/Common/IpTaggedObject.cpp && ./configure --prefix=/usr/local --without-hsl --disable-java && make && make install && cd - && rm -r Ipopt*

# bonmin
RUN curl -fsSL https://www.coin-or.org/download/source/Bonmin/Bonmin-1.8.8.tgz | tar xz && cd Bonmin-1.8.8 && ./configure --prefix=/usr/local --with-ipopt-lib="$(pkg-config --libs ipopt)" --with-ipopt-incdir="/usr/local/include/coin-or/" && make && make install && cd - && rm -r Bonmin*

# dlib
RUN curl -L https://github.com/davisking/dlib/archive/v19.21.tar.gz | tar xz && cd dlib-19.21 \
 && mkdir build && cd build && cmake -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Release .. && make install && cd - && rm -r dlib*

# cminpack
RUN curl -fsSL https://github.com/devernay/cminpack/archive/v1.3.8.tar.gz | tar xz && cd cminpack-1.3.8 \
 && cmake -DBUILD_SHARED_LIBS=ON -DBUILD_EXAMPLES=OFF . && make install && cd - && rm -r cminpack*

# eigen
RUN curl -fsSL https://gitlab.com/libeigen/eigen/-/archive/3.3.9/eigen-3.3.9.tar.bz2 | tar xj && cd eigen-3.3.9 \
 && mkdir build && cd build && cmake -DBUILD_EXAMPLES=OFF .. && make install && cd - && rm -r eigen*

# spectra
RUN curl -fsSL https://github.com/yixuan/spectra/archive/v1.0.0.tar.gz | tar xz && cd spectra-1.0.0 && cmake . && make install && cd - && rm -r spectra*

# glog
RUN curl -fsSL https://github.com/google/glog/archive/v0.5.0.tar.gz | tar xz && cd glog-0.5.0 && cmake . && make install && cd - && rm -r glog*

# ceres
RUN curl -fsSL https://github.com/ceres-solver/ceres-solver/archive/1.14.0.tar.gz | tar xz && cd ceres-solver-1.14.0 \
 && cmake -DBUILD_SHARED_LIBS=ON . && make install && cd - && rm -r ceres*

# boost
RUN curl -fSsL https://boostorg.jfrog.io/artifactory/main/release/1.75.0/source/boost_1_75_0.tar.bz2 | tar xj && cd boost_1_75_0 \
 && ./bootstrap.sh --with-toolset=gcc --with-icu --with-python=/usr/local/bin/python \
 && ./b2 -q variant=release address-model=64 architecture=x86 debug-symbols=off threading=multi runtime-link=shared link=shared toolset=gcc --layout=system ${MAKEFLAGS} install --with-system && cd - && rm -r boost*

# nlopt
RUN curl -L https://github.com/stevengj/nlopt/archive/v2.7.0.tar.gz | tar xz && cd nlopt-2.7.0 \
 && cmake -DWITH_THREADLOCAL=OFF . && make install && cd - && rm -r nlopt*

# swig
RUN curl -L https://github.com/swig/swig/archive/rel-4.0.2.tar.gz | tar xz && cd swig-rel-4.0.2 \
 && ./autogen.sh && ./configure --without-alllang && make && make install && swig -version && cd - && rm -r swig*

# tbb
RUN curl -L https://github.com/oneapi-src/oneTBB/archive/2020_U2.tar.gz | tar xz && cd oneTBB-2020_U2 \
 && make \
 && cp `find . -name "libtbb*.so*" | grep release` /usr/local/lib \
 && cp -r ./include/tbb /usr/local/include \
 && cd - && rm -r oneTBB* \
 && cd /usr/local/lib \
 && ln -sf libtbb.so.2 libtbb.so \
 && ln -sf libtbbmalloc.so.2 libtbbmalloc.so \
 && ln -sf libtbbmalloc_proxy.so.2 libtbbmalloc_proxy.so

# libxml2
RUN curl -fsSL http://xmlsoft.org/sources/libxml2-2.9.12.tar.gz | tar xz && cd libxml2-2.9.12 \
 && ./configure --without-python && make && make install && cd - && rm -r libxml2*

# hdf5
RUN curl -fsSL https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.12/hdf5-1.12.1/src/hdf5-1.12.1.tar.bz2 | tar xj && cd hdf5-1.12.1 && ./configure --enable-cxx --prefix=/usr/local --disable-tests --disable-tools && make && make install && cd - && rm -r hdf5*

# fftw
RUN curl -fsSL http://www.fftw.org/fftw-3.3.9.tar.gz | tar xz && cd fftw-3.3.9 && ./configure --enable-shared --disable-static && make && make install && cd - && rm -r fftw*

RUN cd /tmp && git clone --depth 1 https://github.com/openturns/openturns.git && cd openturns && cmake -DCMAKE_INSTALL_PREFIX=$PWD/install -DCMAKE_UNITY_BUILD=ON -DCMAKE_UNITY_BUILD_BATCH_SIZE=32 -DSWIG_COMPILE_FLAGS="-O0" -DCMAKE_CXX_FLAGS="-Wall -D_GLIBCXX_ASSERTIONS" -DPYTHON_INCLUDE_DIR=/opt/python/cp37-cp37m/include/python3.7m -DPYTHON_LIBRARY=/usr/lib64/libpython2.4.so -DPYTHON_EXECUTABLE=/opt/python/cp37-cp37m/bin/python . && make install && ctest -R "Ipopt|Bonmin|NLopt|Ceres|Dlib|CMinpack|Study_saveload|Sample_csv" -E cppcheck --output-on-failure && cd - && rm -r openturns*

