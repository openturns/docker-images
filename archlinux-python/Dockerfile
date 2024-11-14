# ArchLinux image with Python dependencies

FROM openturns/archlinux-base
MAINTAINER jschueller

WORKDIR /tmp

RUN sudo pacman -Syu swig lapack libxml2 mold lcov ceres-solver nlopt boost eigen --noconfirm
RUN git clone --depth 1 https://github.com/openturns/openturns.git
RUN cd openturns && cmake -DCMAKE_INSTALL_PREFIX=~/.local \
      -DCMAKE_UNITY_BUILD=ON -DCMAKE_UNITY_BUILD_BATCH_SIZE=32 \
      -DCMAKE_C_FLAGS="--coverage" -DCMAKE_CXX_FLAGS="--coverage -fuse-ld=mold" \
      -DSWIG_COMPILE_FLAGS="-O1" -DUSE_TBB=OFF .
RUN cd openturns && make OT -j16 && make install -j12
RUN cd openturns && ctest -E "cppcheck|Factory" -R "Distribution" --output-on-failure -j12 --repeat after-timeout:2 --schedule-random
RUN cd openturns && gcov `find lib/src/ -name "*.gcno"`
RUN echo "gcov OK"
RUN cd openturns && lcov --capture --directory . --output-file coverage.info --include "*.cxx"
#--exclude "*_wrap.cxx"
RUN echo "lcov OK"
RUN cd openturns && genhtml --profile --output-directory coverage coverage.info
RUN echo "genhtml OK"

