#!/bin/sh
set -xe

cd /tmp/lcov
sudo make PREFIX="/usr" CFG_DIR=/etc install
genhtml --version

cd /tmp
rm -rf nlopt
git clone --depth 1 https://github.com/stevengj/nlopt.git
cd nlopt
cmake -DCMAKE_INSTALL_PREFIX=$PWD/install \
      -DCMAKE_UNITY_BUILD=ON -DCMAKE_UNITY_BUILD_BATCH_SIZE=32 \
      -DCMAKE_C_FLAGS="--coverage" -DCMAKE_CXX_FLAGS="--coverage" \
      -DSWIG_COMPILE_FLAGS="-O1" -DNLOPT_TESTS=ON -DNLOPT_GUILE=OFF -DNLOPT_OCTAVE=OFF .
make install -j8
ctest -R "memoize|python" --output-on-failure -j12 --repeat after-timeout:2 --schedule-random
gcov `find src/ -name "*.gcno"`
echo "gcov OK"
lcov --capture --directory . --output-file coverage.info --include "*_wrap.cxx"
echo "lcov OK"
ulimit -Sv 100000
genhtml --profile --output-directory coverage coverage.info
echo "genhtml OK"
