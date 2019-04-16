
FROM quay.io/pypa/manylinux1_x86_64:latest
MAINTAINER jschueller

ENV MAKEFLAGS -j8
WORKDIR /usr/local/src

RUN yum install -y blas-devel lapack-devel zlib-devel xz-devel pcre-devel zip

# cmake
RUN curl -fsSL https://cmake.org/files/v3.9/cmake-3.9.6.tar.gz | tar xz && cd cmake-3.9.6 \
 && ./bootstrap --parallel=8 && make install && cmake --version

# cminpack
RUN curl -fsSL https://github.com/devernay/cminpack/archive/v1.3.6.tar.gz | tar xz && cd cminpack-1.3.6 \
 && cmake -DBUILD_EXAMPLES=OFF . && make install

# eigen
RUN curl -fsSL http://bitbucket.org/eigen/eigen/get/3.3.7.tar.bz2 | tar xj && cd eigen-eigen-323c052e1731 \
 && mkdir build && cd build && cmake -DBUILD_EXAMPLES=OFF .. && make install

# glog
RUN curl -fsSL https://github.com/google/glog/archive/v0.4.0.tar.gz | tar xz && cd glog-0.4.0 \
 && cmake . && make install

# ceres
RUN curl -fsSL https://github.com/ceres-solver/ceres-solver/archive/1.14.0.tar.gz | tar xz && cd ceres-solver-1.14.0 \
 && cmake . && make install

# boost
RUN curl -fsSL https://dl.bintray.com/boostorg/release/1.70.0/source/boost_1_70_0.tar.bz2 | tar xj && cd boost_1_70_0 \
 && ./bootstrap.sh --with-toolset=gcc --with-icu --with-python=/usr/local/bin/python \
 && ./b2 -q variant=release address-model=64 architecture=x86 debug-symbols=off threading=multi runtime-link=shared link=shared toolset=gcc --layout=system ${MAKEFLAGS} install --with-system

# muparser
RUN curl -L https://github.com/beltoforion/muparser/archive/v2.2.5.tar.gz | tar xz && cd muparser-2.2.5 \
 && ./configure --disable-samples && make && make install

# nlopt
RUN curl -L https://github.com/stevengj/nlopt/releases/download/nlopt-2.4.2/nlopt-2.4.2.tar.gz | tar xz && cd nlopt-2.4.2 \
 && ./configure --without-python --without-guile --without-octave --enable-shared --disable-static && make && make install

# optpp
RUN curl -fSsL https://software.sandia.gov/opt++//downloads/optpp-2.4.tar.gz | tar xz && cd optpp-2.4 \
  && ./configure --enable-shared --disable-static && make && make install

# swig
RUN curl -L https://github.com/swig/swig/archive/rel-3.0.12.tar.gz | tar xz && cd swig-rel-3.0.12 \
 && ./autogen.sh && ./configure --without-alllang && make && make install && swig -version

# tbb
RUN curl -L https://github.com/01org/tbb/archive/2018_U3.tar.gz | tar xz && cd tbb-2018_U3 \
 && make \
 && cp `find . -name "libtbb*.so*" | grep release` /usr/local/lib \
 && cd /usr/local/lib \
 && ln -sf libtbb.so.2 libtbb.so \
 && ln -sf libtbbmalloc.so.2 libtbbmalloc.so \
 && ln -sf libtbbmalloc_proxy.so.2 libtbbmalloc_proxy.so \
 && cd - \
 && cp -r ./include/tbb /usr/local/include

# libxml2-devel (=2.6.26) from centos segfaults in _xmlParserInputBufferCreateFilename on bionic
RUN curl -fsSL http://xmlsoft.org/sources/libxml2-2.9.1.tar.gz | tar xz && cd libxml2-2.9.1 \
 && ./configure --without-python && make && make install
