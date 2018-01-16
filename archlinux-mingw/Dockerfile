# ArchLinux image with MinGW toolchain

FROM base/archlinux:latest
MAINTAINER jschueller

# Locale
RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Update base system
RUN    pacman -Sy --noconfirm --noprogressbar archlinux-keyring \
    && pacman-key --populate \
    && pacman -Su --noconfirm --noprogressbar pacman \
    && pacman-db-upgrade \
    && pacman -Su --noconfirm --noprogressbar ca-certificates \
    && trust extract-compat \
    && pacman -Syyu --noconfirm --noprogressbar \
    && (echo -e "y\ny\n" | pacman -Scc)

# Add mingw-repo
RUN    echo "[ownstuff]" >> /etc/pacman.conf \
    && echo "SigLevel = Optional TrustAll" >> /etc/pacman.conf \
    && echo "Server = https://martchus.no-ip.biz/repo/arch/ownstuff/os/\$arch" >> /etc/pacman.conf \
    && pacman -Sy

# Add archlinuxfr repo (yaourt)
RUN    echo "[archlinuxfr]" >> /etc/pacman.conf \
    && echo "SigLevel = Never" >> /etc/pacman.conf \
    && echo "Server = http://repo.archlinux.fr/\$arch" >> /etc/pacman.conf \
    && pacman -Sy

# Add multilib repo
RUN echo "[multilib]" >> /etc/pacman.conf && echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf && pacman -Sy

# Add some useful packages to the base system
RUN pacman -S --noconfirm --noprogressbar base-devel git sudo yaourt winetricks lib32-libldap swig xorg-server-xvfb gdb vim

# Install MinGW packages
RUN pacman -S --noconfirm --noprogressbar mingw-w64-cmake mingw-w64-libxml2 mingw-w64-boost mingw-w64-lapack

# Create devel user...
RUN useradd -m -d /home/devel -u 1000 -U -G users,tty -s /bin/bash devel

# Add user to build packages
RUN echo 'devel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER devel
ENV TERM dumb
ENV MAKEFLAGS "-j8"

# Install MinGW packages from AUR
RUN yaourt -S mingw-w64-muparser mingw-w64-nlopt mingw-w64-hmat-oss mingw-w64-intel-tbb --noconfirm
RUN yaourt -S mingw-w64-python-bin mingw-w64-python2-bin mingw-w64-python35-bin --noconfirm
RUN yaourt -S nsis --noconfirm
