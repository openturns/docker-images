
FROM quay.io/pypa/manylinux1_x86_64:latest
MAINTAINER jschueller

ENV MAKEFLAGS -j8
WORKDIR /usr/local/src

RUN yum install -y blas-devel lapack-devel libxml2-devel pcre-devel zip

RUN wget --no-check-certificate https://cmake.org/files/v3.9/cmake-3.9.6.tar.gz \
 && tar xzf cmake-3.9.6.tar.gz && cd cmake-3.9.6 \
 && ./bootstrap --parallel=8 && make install \
 && cmake --version

RUN curl -L https://github.com/beltoforion/muparser/archive/v2.2.5.tar.gz -o /tmp/v2.2.5.tar.gz \
 && tar xzf /tmp/v2.2.5.tar.gz && cd muparser-2.2.5 \
 && ./configure --disable-samples && make -j2 && make install

RUN curl -L https://github.com/stevengj/nlopt/releases/download/nlopt-2.4.2/nlopt-2.4.2.tar.gz -o /tmp/nlopt-2.4.2.tar.gz \
 && tar xzf /tmp/nlopt-2.4.2.tar.gz && cd nlopt-2.4.2 \
 && ./configure --without-python --without-guile --without-octave --enable-shared --disable-static \
 && make -j2 && make install

RUN curl -L https://github.com/swig/swig/archive/rel-3.0.12.tar.gz -o /tmp/rel-3.0.12.tar.gz \
 && tar xzf /tmp/rel-3.0.12.tar.gz && cd swig-rel-3.0.12 && ./autogen.sh && ./configure --without-alllang \
 && make -j2 && make install \
 && swig -version

RUN curl -L https://github.com/01org/tbb/archive/2018_U3.tar.gz -o /tmp/2018_U3.tar.gz \
 && tar xzf /tmp/2018_U3.tar.gz && cd tbb-2018_U3 \
 && make -j2 \
 && cp `find . -name "libtbb*.so*" | grep release` /usr/local/lib \
 && cd /usr/local/lib \
 && ln -sf libtbb.so.2 libtbb.so \
 && ln -sf libtbbmalloc.so.2 libtbbmalloc.so \
 && ln -sf libtbbmalloc_proxy.so.2 libtbbmalloc_proxy.so \
 && cd - \
 && cp -r ./include/tbb /usr/local/include


