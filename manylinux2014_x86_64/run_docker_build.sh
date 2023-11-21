#!/bin/sh

set -x -e

cd /tmp
git clone --depth 1 https://github.com/openturns/openturns.git
cd openturns
cmake \
  -DCMAKE_INSTALL_PREFIX=$PWD/install \
  -DCMAKE_UNITY_BUILD=ON -DCMAKE_UNITY_BUILD_BATCH_SIZE=32 \
  -DSWIG_COMPILE_FLAGS="-O0 -Wno-unused-parameter" -DCMAKE_CXX_FLAGS="-Wall -Wextra -D_GLIBCXX_ASSERTIONS" \
  -DPython_EXECUTABLE=/opt/python/cp310-cp310/bin/python .
make install
ctest -R "Ipopt|Bonmin|NLopt|Ceres|Dlib|CMinpack|Study|Sample_csv|Sequence|Pagmo|HMatrix|KarhunenLoeveP1Algorithm|SymbolicFunction|Chi" -E cppcheck --output-on-failure --timeout 100 ${MAKEFLAGS}
