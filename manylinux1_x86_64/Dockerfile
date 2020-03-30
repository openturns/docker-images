
FROM quay.io/pypa/manylinux1_x86_64:latest
MAINTAINER jschueller

ENV MAKEFLAGS -j8
WORKDIR /usr/local/src

RUN yum install -y blas-devel lapack-devel atlas-devel zlib-devel xz-devel pcre-devel zip wget bzip2-devel

# cmake
RUN curl -fsSL https://cmake.org/files/v3.12/cmake-3.12.4.tar.gz | tar xz && cd cmake-3.12.4 \
 && ./bootstrap --parallel=8 && make install && cmake --version

# bonmin
RUN curl -fsSL https://www.coin-or.org/download/source/Bonmin/Bonmin-1.8.7.tgz | tar xz && cd Bonmin-1.8.7 \
 && cd ThirdParty/ && cd Metis && ./get.Metis && cd ../Mumps && sed -i "s|http://mumps.enseeiht.fr|https://www.mcs.anl.gov/petsc/mirror/externalpackages|g" get.Mumps && sed -i 's|wgetcmd=wget|wgetcmd="curl -LO"|g' get.Mumps && ./get.Mumps && cd ../.. && ./configure --prefix=/usr/local && make && make install

# dlib
RUN curl -L https://github.com/davisking/dlib/archive/v19.18.tar.gz | tar xz && cd dlib-19.18 \
 && cmake -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Release . && make install && cp -r dlib /usr/local/include

# cminpack
RUN curl -fsSL https://github.com/devernay/cminpack/archive/v1.3.6.tar.gz | tar xz && cd cminpack-1.3.6 \
 && cmake -DBUILD_SHARED_LIBS=ON -DBUILD_EXAMPLES=OFF . && make install

# eigen
RUN curl -fsSL http://bitbucket.org/eigen/eigen/get/3.3.7.tar.bz2 | tar xj && cd eigen-eigen-323c052e1731 \
 && mkdir build && cd build && cmake -DBUILD_EXAMPLES=OFF .. && make install

# glog
RUN curl -fsSL https://github.com/google/glog/archive/v0.4.0.tar.gz | tar xz && cd glog-0.4.0 \
 && cmake . && make install

# ceres
RUN curl -fsSL https://github.com/ceres-solver/ceres-solver/archive/1.14.0.tar.gz | tar xz && cd ceres-solver-1.14.0 \
 && cmake -DBUILD_SHARED_LIBS=ON . && make install

# boost
RUN curl -fsSL https://sourceforge.net/projects/boost/files/boost/1.72.0/boost_1_72_0.tar.bz2 | tar xj && cd boost_1_72_0 \
 && ./bootstrap.sh --with-toolset=gcc --with-icu --with-python=/usr/local/bin/python \
 && ./b2 -q variant=release address-model=64 architecture=x86 debug-symbols=off threading=multi runtime-link=shared link=shared toolset=gcc --layout=system ${MAKEFLAGS} install --with-system

# muparser
RUN curl -L https://github.com/beltoforion/muparser/archive/v2.2.5.tar.gz | tar xz && cd muparser-2.2.5 \
 && ./configure --disable-samples && make && make install

# nlopt
RUN curl -L https://github.com/stevengj/nlopt/archive/v2.6.1.tar.gz | tar xz && cd nlopt-2.6.1 \
 && cmake . && make install

# swig
RUN curl -L https://github.com/swig/swig/archive/rel-4.0.1.tar.gz | tar xz && cd swig-rel-4.0.1 \
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

# test
RUN cd /tmp && git clone --depth 1 https://github.com/openturns/openturns.git && cd openturns && cmake -DUSE_COTIRE=ON -DCOTIRE_MAXIMUM_NUMBER_OF_UNITY_INCLUDES="-j16" -DSWIG_COMPILE_FLAGS="-O0" -DCMAKE_CXX_FLAGS="-Wall -D_GLIBCXX_ASSERTIONS" -DPYTHON_INCLUDE_DIR=/opt/python/cp37-cp37m/include/python3.7m -DPYTHON_LIBRARY=/usr/lib64/libpython2.4.so -DPYTHON_EXECUTABLE=/opt/python/cp37-cp37m/bin/python  . && make install && ctest -R "Bonmin|NLopt|Ceres|Dlib|CMinpack|Study_saveload|muparser" -E cppcheck
