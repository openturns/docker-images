# ArchLinux image with aGrUM

FROM openturns/archlinux-base
MAINTAINER jschueller

# Install some useful packages
RUN sudo pacman -Syu --noconfirm --noprogressbar libglvnd cmake swig python-numpydoc python-sphinx python-matplotlib texlive-latexextra

# Install packages from AUR
RUN aurman -Syu --noconfirm --noedit openturns agrum python-sphinx-gallery
