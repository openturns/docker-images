# ArchLinux image with Python dependencies

FROM openturns/archlinux-base
MAINTAINER jschueller

# Install some useful packages
RUN sudo pacman -Syu --noconfirm --noprogressbar openssh libxml2 boost tbb r ttf-dejavu muparser nlopt hdf5 primesieve \
      python-numpydoc python-pip python-scipy python-pandas python-sphinx python-matplotlib texlive-latexextra

# Install packages from AUR
RUN aurman -S --noconfirm --noedit hmat-oss python-sphinx-gallery python-dill cminpack ceres-solver dlib coin-or-bonmin spectra

