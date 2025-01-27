# ArchLinux image with MinGW toolchain

FROM openturns/archlinux-base
MAINTAINER jschueller

ENV PYTHONIOENCODING="UTF-8"

# Install some useful packages
RUN echo -e "[multilib]\nInclude = /etc/pacman.d/mirrorlist" | sudo tee -a /etc/pacman.conf \
 && sudo pacman -Syu --noconfirm --noprogressbar xorg-server-xvfb wine samba lib32-libldap lib32-gnutls mpg123 lib32-mpg123 gst-plugins-base-libs lib32-gst-plugins-base-libs \
 && echo -e "[ownstuff]\nSigLevel = Optional TrustAll\nServer = https://ftp.f3l.de/~martchus/\$repo/os/\$arch\nServer = https://martchus.dyn.f3l.de/repo/arch/\$repo/os/\$arch" | sudo tee -a /etc/pacman.conf \
 && sudo pacman-key --recv-keys B9E36A7275FC61B464B67907E06FE8F53CDC6A4C && sudo pacman -Sy --noconfirm --noprogressbar

#RUN sudo pacman -U --noconfirm https://archive.archlinux.org/packages/w/wine/wine-9.21-1-x86_64.pkg.tar.zst && echo -e '[options]\nIgnorePkg = wine' | sudo tee -a /etc/pacman.conf

# Install MinGW packages
RUN aurman -Syu --noconfirm --noedit --pgp_fetch nsis mingw-w64-lld mingw-w64-muparser mingw-w64-cminpack mingw-w64-coin-or-bonmin \
    mingw-w64-spectra mingw-w64-cmake mingw-w64-wine mingw-w64-libxml2 mingw-w64-boost mingw-w64-lapack mingw-w64-nlopt mingw-w64-pagmo \
    mingw-w64-ceres-solver mingw-w64-eigen mingw-w64-dlib mingw-w64-onetbb mingw-w64-hdf5 mingw-w64-libmpc mingw-w64-primesieve mingw-w64-nanoflann mingw-w64-libcuba
RUN for pyver in 38 39 310 311 312 313; do aurman -Syu --noconfirm --noedit mingw-w64-python${pyver}-bin; x86_64-w64-mingw32-python${pyver}-bin -c "import sys; print('.'.join([str(x) for x in sys.version_info[:3]]))"; done
