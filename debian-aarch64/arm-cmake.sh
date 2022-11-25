#!/bin/sh

cmake -DCMAKE_TOOLCHAIN_FILE=/usr/share/toolchain-arm.cmake -DCMAKE_BUILD_TYPE=None -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX=/usr/aarch64-linux-gnu "$@"
