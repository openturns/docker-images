# ArchLinux image to compile openturns modules

FROM openturns/archlinux-base
MAINTAINER jschueller

# Install some useful packages
RUN sudo pacman -Syu --noconfirm openscenegraph

RUN sudo pacman -Syu --noconfirm --noprogressbar python-numpydoc python-sphinx python-matplotlib texlive-latexextra

# Install packages from AUR
RUN aurman -Syu --noconfirm --noedit --pgp_fetch openturns agrum python-sphinx-gallery fftw
RUN aurman -Syu  --noconfirm --noedit --pgp_fetch python-pyfmi wayland openmodelica jdk-openjdk python-pytest
