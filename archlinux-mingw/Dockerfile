# ArchLinux image with MinGW toolchain

FROM base/archlinux:latest
MAINTAINER jschueller

# Locale
RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV PYTHONIOENCODING "UTF-8"

# Update base system
RUN    pacman -Sy --noconfirm --noprogressbar archlinux-keyring \
    && pacman-key --populate \
    && pacman -Su --noconfirm --noprogressbar pacman \
    && pacman-db-upgrade \
    && pacman -Su --noconfirm --noprogressbar ca-certificates \
    && trust extract-compat \
    && pacman -Syyu --noconfirm --noprogressbar \
    && (echo -e "y\ny\n" | pacman -Scc)

# Install some useful packages to the base system
RUN echo -e "[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf \
    && pacman -Sy --noconfirm --noprogressbar base-devel git sudo swig xorg-server-xvfb gdb wget vim zip \
    winetricks libldap lib32-libldap gnutls lib32-gnutls mpg123 gst-plugins-base-libs lib32-mpg123 lib32-gst-plugins-base-libs

# Install MinGW packages
RUN echo -e "[ownstuff]\nSigLevel = Optional TrustAll\nServer = https://martchus.no-ip.biz/repo/arch/ownstuff/os/\$arch" >> /etc/pacman.conf \
 && pacman -Sy --noconfirm --noprogressbar nsis mingw-w64-cmake mingw-w64-wine mingw-w64-libxml2 mingw-w64-boost mingw-w64-lapack

# Add devel user to build packages
RUN useradd -m -d /home/devel -u 1000 -U -G users,tty -s /bin/bash devel
RUN echo 'devel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER devel
ENV TERM dumb
ENV MAKEFLAGS "-j8"

# Install AUR helper
RUN git clone https://aur.archlinux.org/aurman.git /tmp/aurman && cd /tmp/aurman \
 && makepkg -sfi --skippgpcheck --noconfirm \
 && mkdir -p ~/.config/aurman/ && echo -e "[miscellaneous]\nskip_news\nskip_new_locations" > ~/.config/aurman/aurman_config

# Install MinGW packages from AUR
RUN aurman -S --noconfirm --noedit mingw-w64-muparser mingw-w64-nlopt mingw-w64-hmat-oss mingw-w64-intel-tbb
RUN aurman -S --noconfirm --noedit mingw-w64-python-bin mingw-w64-python2-bin mingw-w64-python35-bin mingw-w64-python36-bin

# https://bugs.winehq.org/show_bug.cgi?id=42474#c22
RUN sudo rm /usr/lib/wine/api-ms-win-core-path-l1-1-0.dll.so /usr/lib32/wine/api-ms-win-core-path-l1-1-0.dll.so
RUN WINEPREFIX=~/.wine-x86_64-w64-mingw32 WINEARCH=win64 wine wineboot && WINEPREFIX=~/.wine-x86_64-w64-mingw32 WINEARCH=win64 xvfb-run winetricks -q vcrun2015 \
 && WINEPREFIX=~/.wine-i686-w64-mingw32   WINEARCH=win32 wine wineboot && WINEPREFIX=~/.wine-i686-w64-mingw32   WINEARCH=win32 xvfb-run winetricks -q vcrun2015
RUN for arch in i686 x86_64; do for pyver in 27 35 36 37; do ${arch}-w64-mingw32-python${pyver}-bin -c "import sys; sys.stdout.write(';'.join([str(x) for x in sys.version_info[:3]]))"; done; done
