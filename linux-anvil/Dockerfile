
FROM base/archlinux

MAINTAINER jschueller

# setup keyring
RUN export GNUPGHOME=/etc/pacman.d/gnupg/
RUN pacman-key --populate archlinux && pacman-key --refresh-keys

# add yaourt repo
RUN echo '[archlinuxfr]' >> /etc/pacman.conf && echo 'SigLevel = Never' >> /etc/pacman.conf && echo 'Server = http://repo.archlinux.fr/$arch' >> /etc/pacman.conf

# install base packages
RUN pacman -Syu --needed base-devel git yaourt --noconfirm
RUN pacman-db-upgrade

# configure makepkg
RUN cd /usr/bin && curl -O https://aur.archlinux.org/cgit/aur.git/plain/makepkg-asroot.patch?h=makepkg-asroot && patch -p0 -i makepkg-asroot.patch?h=makepkg-asroot && cd -
RUN sed -i 's|#MAKEFLAGS="-j2"|MAKEFLAGS="-j2"|g' /etc/makepkg.conf

# install packages
RUN yaourt -Syu hmat-oss intel-tbb muparser nlopt boost cmake swig libxml2 python-scipy python-sphinx python-matplotlib r --aur --noconfirm
