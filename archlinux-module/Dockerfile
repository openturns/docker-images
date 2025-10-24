# ArchLinux image to compile openturns modules

FROM openturns/archlinux-base

# Install some useful packages
RUN sudo pacman -Syu --noconfirm --noprogressbar python-numpydoc python-sphinx python-sphinx-copybutton python-matplotlib python-pip python-pytest texlive-latexextra

# Install packages from AUR
RUN aurman -Syu --noconfirm --noedit --pgp_fetch openturns agrum python-sphinx-gallery fftw libmixmod lcov vinecopulib
