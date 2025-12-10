FROM openturns/archlinux-mingw:latest

RUN aurman -Syu --pgp_fetch --noconfirm --noedit mingw-w64-agrum mingw-w64-fftw mingw-w64-libmixmod mingw-w64-vinecopulib mingw-w64-cgal

ENV ARCH=x86_64 PYMAJMIN=312
ENV MINGW_PREFIX=/usr/${ARCH}-w64-mingw32

# openturns
WORKDIR /tmp
RUN git clone -b v1.26 --depth 1 https://github.com/openturns/openturns.git && cd openturns \
  && ${ARCH}-w64-mingw32-cmake \
  -DPython_INCLUDE_DIR=${MINGW_PREFIX}/include/python${PYMAJMIN} \
  -DPython_LIBRARY=${MINGW_PREFIX}/lib/libpython${PYMAJMIN}.dll.a \
  -DPython_EXECUTABLE=/usr/bin/${ARCH}-w64-mingw32-python${PYMAJMIN}-bin \
  -DCMAKE_UNITY_BUILD=ON -DCMAKE_UNITY_BUILD_BATCH_SIZE=32 -DSWIG_COMPILE_FLAGS="-O1" . \
  && make && sudo make install \
  && sudo ${ARCH}-w64-mingw32-strip --strip-unneeded ${MINGW_PREFIX}/bin/libOT.dll ${MINGW_PREFIX}/Lib/site-packages/openturns/*.pyd \
  && rm -r /tmp/openturns*

