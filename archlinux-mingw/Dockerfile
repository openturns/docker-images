# ArchLinux image with MinGW toolchain

FROM openturns/archlinux-base
MAINTAINER jschueller

ENV PYTHONIOENCODING="UTF-8"

# Install some useful packages
RUN echo -e "[multilib]\nInclude = /etc/pacman.d/mirrorlist" | sudo tee -a /etc/pacman.conf \
 && sudo pacman -Syu --noconfirm --noprogressbar xorg-server-xvfb \
    wine samba libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 gst-plugins-base-libs lib32-gst-plugins-base-libs texlive-latexextra \
 && echo -e "[ownstuff]\nSigLevel = Optional TrustAll\nServer = https://ftp.f3l.de/~martchus/ownstuff/os/\$arch\nServer = https://martchus.no-ip.biz/repo/arch/\$repo/os/\$arch" | sudo tee -a /etc/pacman.conf \
 && sudo pacman -Sy --noconfirm --noprogressbar

# Install MinGW packages
RUN aurman -Syu --noconfirm --noedit --pgp_fetch nsis mingw-w64-muparser mingw-w64-hmat-oss mingw-w64-cminpack mingw-w64-coin-or-bonmin \
    mingw-w64-spectra mingw-w64-cmake mingw-w64-wine mingw-w64-libxml2 mingw-w64-boost mingw-w64-lapack mingw-w64-nlopt \
    mingw-w64-ceres-solver mingw-w64-eigen mingw-w64-dlib mingw-w64-tbb mingw-w64-hdf5 mingw-w64-libmpc
RUN for pyver in 36 37 38 39; do aurman -Syu --noconfirm --noedit mingw-w64-python${pyver}-bin; x86_64-w64-mingw32-python${pyver}-bin -c "import sys; print('.'.join([str(x) for x in sys.version_info[:3]]))"; done
