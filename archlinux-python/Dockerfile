# ArchLinux image with Python dependencies

FROM openturns/archlinux-base
MAINTAINER jschueller

# Install some useful packages
RUN sudo pacman -Syu --noconfirm --noprogressbar openssh libxml2 boost tbb r muparser nlopt hdf5 \
      python-numpydoc python-pip python-scipy python-pandas python-sphinx python-matplotlib texlive-latexextra

# Install packages from AUR
RUN aurman -S --noconfirm --noedit hmat-oss python-sphinx-gallery python-chaospy python-dill cminpack ceres-solver dlib coin-or-bonmin spectra
