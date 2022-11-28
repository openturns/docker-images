#!/bin/sh

# from dpkg-buildflags
export CPPFLAGS="-Wdate-time -D_FORTIFY_SOURCE=2"
export CXXFLAGS="-g -O2 -fstack-protector-strong -Wformat -Werror=format-security ${CPPFLAGS}"
export CFLAGS="-g -O2 -fstack-protector-strong -Wformat -Werror=format-security ${CPPFLAGS}"
export LDFLAGS="-Wl,-Bsymbolic-functions -Wl,-z,relro"

cmake -DCMAKE_TOOLCHAIN_FILE=/usr/share/toolchain-aarch64.cmake -DCMAKE_BUILD_TYPE=None -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX=/usr/aarch64-linux-gnu "$@"
