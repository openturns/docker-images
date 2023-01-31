FROM debian:bookworm

RUN dpkg --add-architecture arm64 && apt-get -y update && apt-get -y install curl gnupg sudo cmake git qemu-user g++-aarch64-linux-gnu gfortran-aarch64-linux-gnu libc6:arm64 libstdc++6:arm64 bison flex liblapack-dev:arm64 libnlopt-dev:arm64 libdlib-dev:arm64 libboost-math-dev:arm64 libxml2-dev:arm64 libcminpack-dev:arm64 libprimesieve-dev:arm64 libnlopt-cxx-dev:arm64 libceres-dev:arm64 libmpfr-dev:arm64 libmpc-dev:arm64 libgoogle-glog-dev:arm64 libgflags-dev:arm64 libmetis-dev:arm64 libeigen3-dev:arm64 libpng-dev:arm64 libsqlite3-dev:arm64 libjpeg-dev:arm64 swig

# for python3-dev:arm64
RUN apt-get -y install libexpat1-dev:arm64 zlib1g-dev:arm64 python3-distutils libjs-sphinxdoc libbz2-1.0:arm64 libdb5.3:arm64 libmpdec3:arm64 libncursesw6:arm64 libreadline8:arm64 libuuid1:arm64
ADD apt_install_nopost.sh /usr/bin/apt_install_nopost
RUN apt_install_nopost libpython3.11-minimal:arm64 python3.11-minimal:arm64 python3-minimal:arm64 libpython3.11-stdlib:arm64 libpython3-stdlib:arm64 python3.11:arm64 python3:arm64 libpython3.11:arm64 libpython3.11-dev:arm64 libpython3-dev:arm64 python3.11-dev:arm64 python3-dev:arm64

# toolchain files
ADD toolchain-aarch64.cmake /usr/share
ADD aarch64-cmake.sh /usr/bin/aarch64-cmake
ADD aarch64-python.sh /usr/bin/aarch64-python

ENV MAKEFLAGS -j8

RUN useradd -m -d /home/devel -u 1000 -U -G users,tty -s /bin/bash devel
#RUN echo 'devel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER devel
