
FROM quay.io/pypa/manylinux2010_x86_64:latest
MAINTAINER jschueller

ENV MAKEFLAGS -j8
WORKDIR /usr/local/src

RUN yum install -y blas-devel lapack-devel atlas-devel zlib-devel xz-devel pcre-devel zip bzip2-devel wget

# cmake
RUN curl -fsSL https://cmake.org/files/v3.16/cmake-3.16.4.tar.gz | tar xz && cd cmake-3.16.4 \
 && ./bootstrap --parallel=8 -- -DCMAKE_USE_OPENSSL=OFF && make install && cmake --version

# ipopt
RUN curl -fsSL https://bitbucket.org/petsc/pkg-metis/get/v5.1.0-p8.tar.bz2 | tar xj && cd petsc-pkg-metis-* && make config shared=1 && make install
RUN curl -fsSL https://github.com/coin-or-tools/ThirdParty-Mumps/archive/releases/1.6.2.tar.gz | tar xz && cd ThirdParty-Mumps-releases-1.6.2 && ./get.Mumps && ./configure --prefix=/usr/local && make && make install
RUN curl -fsSL http://www.coin-or.org/download/source/Ipopt/Ipopt-3.13.2.tgz | tar xz && cd Ipopt-releases-3.13.2 && ./configure --prefix=/usr/local --without-hsl --disable-java && make && make install

# bonmin
RUN curl -fsSL https://www.coin-or.org/download/source/Bonmin/Bonmin-1.8.8.tgz | tar xz && cd Bonmin-1.8.8 && ./configure --prefix=/usr/local --with-ipopt-lib="$(pkg-config --libs ipopt)" --with-ipopt-incdir="/usr/local/include/coin-or/" && make && make install

# dlib
RUN curl -L https://github.com/davisking/dlib/archive/v19.19.tar.gz | tar xz && cd dlib-19.19 \
 && mkdir build && cd build && cmake -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Release .. && make install

# cminpack
RUN curl -fsSL https://github.com/devernay/cminpack/archive/v1.3.6.tar.gz | tar xz && cd cminpack-1.3.6 \
 && cmake -DBUILD_SHARED_LIBS=ON -DBUILD_EXAMPLES=OFF . && make install

# eigen
RUN curl -fsSL http://bitbucket.org/eigen/eigen/get/3.3.7.tar.bz2 | tar xj && cd eigen-eigen-323c052e1731 \
 && mkdir build && cd build && cmake -DBUILD_EXAMPLES=OFF .. && make install

# spectra
RUN curl -fsSL https://github.com/yixuan/spectra/archive/v0.9.0.tar.gz | tar xz && cd spectra-0.9.0 && cmake . && make install

# glog
RUN curl -fsSL https://github.com/google/glog/archive/v0.4.0.tar.gz | tar xz && cd glog-0.4.0 \
 && cmake . && make install

# ceres
RUN curl -fsSL https://github.com/ceres-solver/ceres-solver/archive/1.14.0.tar.gz | tar xz && cd ceres-solver-1.14.0 \
 && cmake -DBUILD_SHARED_LIBS=ON . && make install

# boost
RUN curl -fsSL https://sourceforge.net/projects/boost/files/boost/1.73.0/boost_1_73_0.tar.bz2 | tar xj && cd boost_1_73_0 \
 && ./bootstrap.sh --with-toolset=gcc --with-icu --with-python=/usr/local/bin/python \
 && ./b2 -q variant=release address-model=64 architecture=x86 debug-symbols=off threading=multi runtime-link=shared link=shared toolset=gcc --layout=system ${MAKEFLAGS} install --with-system

# nlopt
RUN curl -L https://github.com/stevengj/nlopt/archive/v2.6.2.tar.gz | tar xz && cd nlopt-2.6.2 \
 && cmake . && make install

# swig
RUN curl -L https://github.com/swig/swig/archive/rel-4.0.1.tar.gz | tar xz && cd swig-rel-4.0.1 \
 && ./autogen.sh && ./configure --without-alllang && make && make install && swig -version

# tbb
RUN curl -L https://github.com/oneapi-src/oneTBB/archive/2020_U2.tar.gz | tar xz && cd oneTBB-2020_U2/ \
 && make \
 && cp `find . -name "libtbb*.so*" | grep release` /usr/local/lib \
 && cd /usr/local/lib \
 && ln -sf libtbb.so.2 libtbb.so \
 && ln -sf libtbbmalloc.so.2 libtbbmalloc.so \
 && ln -sf libtbbmalloc_proxy.so.2 libtbbmalloc_proxy.so \
 && cd - \
 && cp -r ./include/tbb /usr/local/include

# libxml2
RUN curl -fsSL http://xmlsoft.org/sources/libxml2-2.9.10.tar.gz | tar xz && cd libxml2-2.9.10 \
 && ./configure --without-python && make && make install

# test
RUN cd /tmp && git clone --depth 1 https://github.com/openturns/openturns.git && cd openturns && cmake -DCMAKE_UNITY_BUILD=ON -DUNITY_BUILD_BATCH_SIZE=32 -DSWIG_COMPILE_FLAGS="-O1" -DCMAKE_CXX_FLAGS="-Wall -D_GLIBCXX_ASSERTIONS" -DPYTHON_INCLUDE_DIR=/opt/python/cp37-cp37m/include/python3.7m -DPYTHON_LIBRARY=/usr/lib64/libpython2.4.so -DPYTHON_EXECUTABLE=/opt/python/cp37-cp37m/bin/python -DCMAKE_INSTALL_PREFIX=$PWD/install . && make install && ctest -R "Ipopt|Bonmin|NLopt|Ceres|Dlib|CMinpack|Study_saveload|muparser" -E cppcheck

