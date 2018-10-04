
FROM quay.io/pypa/manylinux1_x86_64:latest
MAINTAINER jschueller

ENV MAKEFLAGS -j8
WORKDIR /usr/local/src

RUN yum install -y blas-devel lapack-devel zlib-devel xz-devel pcre-devel zip

# cmake
RUN curl -fsSL https://cmake.org/files/v3.9/cmake-3.9.6.tar.gz | tar xz && cd cmake-3.9.6 \
 && ./bootstrap --parallel=8 && make install && cmake --version

# boost
RUN curl -L https://dl.bintray.com/boostorg/release/1.64.0/source/boost_1_64_0.tar.bz2 | tar xj && cd boost_1_64_0 \
 && ./bootstrap.sh --with-toolset=gcc --with-icu --with-python=/usr/local/bin/python \
 && ./b2 -q variant=release address-model=64 architecture=x86 debug-symbols=off threading=multi runtime-link=shared link=shared toolset=gcc --layout=system ${MAKEFLAGS} install \
 --without-atomic --without-chrono --without-container --without-context --without-coroutine --without-coroutine2 --without-date_time \
 --without-exception --without-fiber --without-filesystem --without-graph --without-graph_parallel --without-iostreams \
 --without-locale --without-log --without-math --without-metaparse --without-mpi --without-program_options --without-python --without-random --without-regex \
 --without-serialization --without-signals --without-system --without-test --without-thread \
 --without-timer --without-type_erasure --without-wave

# muparser
RUN curl -L https://github.com/beltoforion/muparser/archive/v2.2.5.tar.gz | tar xz && cd muparser-2.2.5 \
 && ./configure --disable-samples && make && make install

# nlopt
RUN curl -L https://github.com/stevengj/nlopt/releases/download/nlopt-2.4.2/nlopt-2.4.2.tar.gz | tar xz && cd nlopt-2.4.2 \
 && ./configure --without-python --without-guile --without-octave --enable-shared --disable-static && make && make install

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