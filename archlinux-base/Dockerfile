# ArchLinux image with compatibility for linux 4.x hosts

# downgrade to kernel 5.9: sudo pacman -U https://archive.archlinux.org/packages/l/linux/linux-5.9.14.arch1-1-x86_64.pkg.tar.zst https://archive.archlinux.org/packages/l/linux-headers/linux-headers-5.9.14.arch1-1-x86_64.pkg.tar.zst

FROM archlinux:base-devel
MAINTAINER jschueller

# re-include locale files
RUN sed -i -e "s|NoExtract   =|#NoExtract   =|g" -e "s|NoExtract  = usr/share/locale|#NoExtract  = usr/share/locale|g" /etc/pacman.conf && cat /etc/pacman.conf | grep NoExtract

# Update base system
RUN pacman-key --init && pacman-key --populate \
 && pacman -Syu --noconfirm --noprogressbar pacman \
 && pacman-db-upgrade \
 && pacman -Su --noconfirm --noprogressbar ca-certificates \
 && trust extract-compat \
 && pacman -Syyu --noconfirm --noprogressbar git zip swig cmake \
 && pacman -Scc --noconfirm

# Add devel user to build packages
RUN useradd -m -d /home/devel -u 1000 -U -G users,tty -s /bin/bash devel
RUN echo 'devel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER devel
ENV TERM=dumb MAKEFLAGS="-j8"
RUN git config --global user.email devel@a.b && git config --global user.name devel

# Rebuild glibc
ADD glibc-linux4-syscalls.patch /tmp
RUN git clone --depth 1 -b packages/glibc https://github.com/archlinux/svntogit-packages.git /tmp/glibc && cd /tmp/glibc/trunk \
 && sed -i '0,/cd glibc/{s//cd glibc \&\& patch -p1 -i \/tmp\/glibc-linux4-syscalls.patch/}; s|make check|true|g' PKGBUILD \
 && sed -i 's|CPPFLAGS=${CPPFLAGS/-D_FORTIFY_SOURCE=2/}|CFLAGS=${CFLAGS/-Wp,-D_FORTIFY_SOURCE=2/}\n  CXXFLAGS=${CXXFLAGS/-Wp,-D_FORTIFY_SOURCE=2/}\n|g' PKGBUILD \
 && cat PKGBUILD && makepkg -sfi --skipinteg --noconfirm && rm -r /tmp/glibc \
 && sudo sed -i "s|#IgnorePkg   =|IgnorePkg = glibc lib32-glibc|g" /etc/pacman.conf && cat /etc/pacman.conf | grep IgnorePkg

# Install AUR helper
RUN sudo pacman -S python-setuptools --noconfirm \
 && git clone https://aur.archlinux.org/aurman.git /tmp/aurman && cd /tmp/aurman \
 && makepkg -sfi --skippgpcheck --noconfirm \
 && sudo chmod a+r /usr/lib/python*/site-packages/aurman/*.py \
 && mkdir -p ~/.config/aurman/ && echo -e "[miscellaneous]\nskip_news\nskip_new_locations\nno_sudo_loop" > ~/.config/aurman/aurman_config

# Configure pacman to drop cache
RUN aurman -Syu --noconfirm --noedit --pgp_fetch paccache-hook && sudo sed -i "s|installed_keep=2|installed_keep=0|g" /etc/paccache-hook.conf

