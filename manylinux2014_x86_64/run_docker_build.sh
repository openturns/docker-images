#!/bin/sh

set -x -e

cd /tmp
git clone --depth 1 https://github.com/openturns/openturns.git
cd openturns
cmake \
  -DCMAKE_INSTALL_PREFIX=$PWD/install \
  -DCMAKE_UNITY_BUILD=ON -DCMAKE_UNITY_BUILD_BATCH_SIZE=32 \
  -DSWIG_COMPILE_FLAGS="-O0" -DCMAKE_CXX_FLAGS="-Wall -D_GLIBCXX_ASSERTIONS" \
  -DPYTHON_INCLUDE_DIR=/opt/python/cp310-cp310/include/python3.10 \
  -DPYTHON_LIBRARY=dummy \
  -DPYTHON_EXECUTABLE=/opt/python/cp310-cp310/bin/python .
make install
ctest -R "Ipopt|Bonmin|NLopt|Ceres|Dlib|CMinpack|Study|Sample_csv|Sequence|Pagmo|HMatrix|KarhunenLoeveP1Algorithm|SymbolicFunction|Chi" -E cppcheck --output-on-failure --timeout 100 ${MAKEFLAGS}
