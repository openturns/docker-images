
FROM ubuntu:trusty
MAINTAINER jschueller

ENV MAKEFLAGS "-j8"
WORKDIR /tmp

# mimic circleci image
RUN apt-get -y update
RUN apt-get install -y git wget python curl
RUN curl -sSLO https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py
RUN pip install -U pip wheel setuptools --upgrade
RUN useradd -m -d /home/ubuntu -u 1000 -U -G users,tty -s /bin/bash ubuntu
RUN echo 'ubuntu ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER ubuntu

# mirror openturns/circle.yml
RUN sudo apt-get -y update
RUN sudo apt-get install -y cmake gfortran bison flex libmuparser-dev liblapack-dev libxml2-dev libboost-math-dev libtbb-dev libnlopt-dev r-base-core
RUN sudo apt-get install -y python-dev python-scipy python-matplotlib texlive-latex-recommended texlive-fonts-recommended texlive-latex-extra pandoc
RUN pip install matplotlib git+https://github.com/sphinx-doc/sphinx.git numpydoc nbsphinx jupyter_client ipython==5.* --user --upgrade
RUN git clone https://github.com/swig/swig.git && cd swig \
 && ./autogen.sh && ./configure --prefix=$HOME/.local --without-alllang \
 && make && make install
RUN git clone https://github.com/jeromerobert/hmat-oss.git && cd hmat-oss \
 && cmake -DCMAKE_INSTALL_PREFIX=~/.local . && make install

# mirror openturns/ci_support/build.sh
RUN git clone https://github.com/openturns/openturns.git && cd openturns \
 && R CMD INSTALL --library=$PWD utils/rot_1.4.6.tar.gz && export R_LIBS=$PWD \
 && cmake -DCMAKE_INSTALL_PREFIX=~/.local \
      -DSPHINX_EXECUTABLE=~/.local/bin/sphinx-build \
      -DSWIG_EXECUTABLE=~/.local/bin/swig \
      -DHMAT_DIR=~/.local/lib/cmake/hmat \
      -DUSE_COTIRE=ON -DCOTIRE_MAXIMUM_NUMBER_OF_UNITY_INCLUDES="-j8" \
 && make install && ctest -R pyinstallcheck -j8
