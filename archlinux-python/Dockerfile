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
RUN cd openturns && ctest -E "cppcheck|Factory" -R "Distribution|Function" --output-on-failure -j12 --repeat after-timeout:2 --schedule-random
# RUN sudo pacman -S python swig cmake lapack libxml2 git --noconfirm
RUN cd openturns && gcov `find lib/src/ -name "*.gcno"`
RUN cd openturns && lcov --capture --directory . --output-file coverage.info --include "*.cxx"
RUN cd openturns && genhtml --output-directory coverage coverage.info
