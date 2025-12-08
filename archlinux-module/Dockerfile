# ArchLinux image to compile openturns modules

FROM openturns/archlinux-base
RUN sudo pacman -Syu --noconfirm --noprogressbar python-numpydoc python-sphinx python-sphinx-copybutton python-matplotlib python-pip python-pytest texlive-latexextra fftw lcov cgal qhull cddlib

# Install packages from AUR
RUN aurman -Syu --noconfirm --noedit --pgp_fetch openturns agrum python-sphinx-gallery libmixmod vinecopulib
