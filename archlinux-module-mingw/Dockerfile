FROM openturns/archlinux-mingw:latest
MAINTAINER jschueller

RUN aurman -Syu --pgp_fetch --noconfirm --noedit mingw-w64-agrum mingw-w64-fftw

ENV ARCH=x86_64 PYMAJMIN=310
ENV MINGW_PREFIX /usr/${ARCH}-w64-mingw32

# openturns
RUN git clone https://github.com/openturns/openturns.git /tmp/openturns && cd /tmp/openturns && git checkout v1.18 \
  && ${ARCH}-w64-mingw32-cmake \
  -DPYTHON_INCLUDE_DIR=${MINGW_PREFIX}/include/python${PYMAJMIN} -DPYTHON_LIBRARY=${MINGW_PREFIX}/lib/libpython${PYMAJMIN}.dll.a \
  -DPYTHON_EXECUTABLE=/usr/bin/${ARCH}-w64-mingw32-python${PYMAJMIN}-bin \
  -DCMAKE_UNITY_BUILD=ON -DCMAKE_UNITY_BUILD_BATCH_SIZE=32 -DSWIG_COMPILE_FLAGS="-O1" -DUSE_SPHINX=OFF . \
  && make -j2 && sudo make install \
  && sudo ${ARCH}-w64-mingw32-strip --strip-unneeded ${MINGW_PREFIX}/bin/libOT.dll ${MINGW_PREFIX}/Lib/site-packages/openturns/*.pyd \
  && rm -r /tmp/openturns*

