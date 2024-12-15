# ArchLinux image with MinGW toolchain

FROM openturns/archlinux-base
MAINTAINER jschueller

ENV PYTHONIOENCODING="UTF-8"

# Install some useful packages
RUN echo -e "[multilib]\nInclude = /etc/pacman.d/mirrorlist" | sudo tee -a /etc/pacman.conf \
 && sudo pacman -Syu --noconfirm --noprogressbar xorg-server-xvfb wine samba lib32-libldap lib32-gnutls mpg123 lib32-mpg123 gst-plugins-base-libs lib32-gst-plugins-base-libs \
 && echo -e "[ownstuff]\nSigLevel = Optional TrustAll\nServer = https://ftp.f3l.de/~martchus/\$repo/os/\$arch\nServer = https://martchus.dyn.f3l.de/repo/arch/\$repo/os/\$arch" | sudo tee -a /etc/pacman.conf \
 && sudo pacman-key --recv-keys B9E36A7275FC61B464B67907E06FE8F53CDC6A4C && sudo pacman -Sy --noconfirm --noprogressbar

#RUN sudo pacman -U --noconfirm https://archive.archlinux.org/packages/w/wine/wine-7.16-1-x86_64.pkg.tar.zst && echo -e '[options]\nIgnorePkg = wine' | sudo tee -a /etc/pacman.conf

# Install MinGW packages
RUN aurman -Syu --noconfirm --noedit --pgp_fetch mingw-w64-gcc mingw-w64-wine

WORKDIR /tmp
RUN curl -O https://gitlab.kitware.com/vtk/vtk/-/raw/master/CMake/vtkRequireLargeFilesSupport.cxx
RUN wine --version
RUN g++ vtkRequireLargeFilesSupport.cxx && ./a.out
RUN x86_64-w64-mingw32-g++ vtkRequireLargeFilesSupport.cxx && x86_64-w64-mingw32-wine ./a.exe
