# ArchLinux image with MinGW toolchain

FROM archlinux/base
MAINTAINER jschueller

# Locale
RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8 PYTHONIOENCODING="UTF-8"

# Update base system
RUN pacman-key --init && pacman-key --populate \
    && pacman -Syu --noconfirm --noprogressbar pacman \
    && pacman-db-upgrade \
    && pacman -Su --noconfirm --noprogressbar ca-certificates \
    && trust extract-compat \
    && pacman -Syyu --noconfirm --noprogressbar \
    && pacman -Scc --noconfirm

# Install some useful packages to the base system
RUN echo -e "[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf \
    && pacman -Sy --noconfirm --noprogressbar base-devel git sudo swig xorg-server-xvfb zip openssh \
    wine samba libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 gst-plugins-base-libs lib32-gst-plugins-base-libs texlive-latexextra

# Use ownstuff repo
RUN echo -e "[ownstuff]\nSigLevel = Optional TrustAll\nServer = https://ftp.f3l.de/~martchus/ownstuff/os/\$arch\nServer = https://martchus.no-ip.biz/repo/arch/\$repo/os/\$arch" >> /etc/pacman.conf && pacman -Sy --noconfirm --noprogressbar

# Add devel user to build packages
RUN useradd -m -d /home/devel -u 1000 -U -G users,tty -s /bin/bash devel
RUN echo 'devel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER devel
ENV TERM dumb
ENV MAKEFLAGS "-j8"
RUN git config --global user.email devel@a.b && git config --global user.name devel

# Rebuild glibc without time64 syscalls for compatibility with linux<5.1 hosts
ADD glibc-disable-time64-syscalls.patch /tmp
RUN git clone --depth 1 -b packages/glibc https://github.com/archlinux/svntogit-packages.git /tmp/glibc && cd /tmp/glibc/trunk \
 && sed -i '0,/cd glibc/{s//cd glibc \&\& patch -p1 -i \/tmp\/glibc-disable-time64-syscalls.patch/}; s|make check|true|g' PKGBUILD \
 && cat PKGBUILD && makepkg -sfi --skipinteg --noconfirm | sed -n '0~100p' && rm -r /tmp/glibc \
 && sudo sed -i "s|#IgnorePkg   =|IgnorePkg = glibc lib32-glibc|g" /etc/pacman.conf && cat /etc/pacman.conf

# Install AUR helper
RUN git clone https://aur.archlinux.org/aurman.git /tmp/aurman && cd /tmp/aurman \
 && makepkg -sfi --skippgpcheck --noconfirm \
 && sudo chmod a+r /usr/lib/python*/site-packages/aurman/*.py \
 && mkdir -p ~/.config/aurman/ && echo -e "[miscellaneous]\nskip_news\nskip_new_locations\nno_sudo_loop" > ~/.config/aurman/aurman_config

# Install MinGW packages
RUN aurman -Syu --noconfirm --noedit nsis mingw-w64-muparser mingw-w64-hmat-oss mingw-w64-cminpack mingw-w64-coin-or-bonmin \
    mingw-w64-spectra mingw-w64-cmake mingw-w64-wine mingw-w64-libxml2 mingw-w64-boost mingw-w64-lapack mingw-w64-nlopt \
    mingw-w64-ceres-solver mingw-w64-eigen mingw-w64-dlib mingw-w64-tbb mingw-w64-hdf5
RUN for pyver in 36 37 38 39; do aurman -Syu --noconfirm --noedit mingw-w64-python${pyver}-bin; x86_64-w64-mingw32-python${pyver}-bin -c "import sys; print('.'.join([str(x) for x in sys.version_info[:3]]))"; done
