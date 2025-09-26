# ArchLinux image with Python dependencies

FROM openturns/archlinux-base

# Install some useful packages
RUN sudo pacman -Syu --noconfirm --noprogressbar openssh libxml2 boost tbb muparser nlopt hdf5 primesieve mold lcov perl-clone-choose \
      python-numpydoc python-pip python-scipy python-pandas python-sphinx python-sphinx-copybutton python-sphinxcontrib-jquery python-matplotlib texlive-latexextra texlive-mathscience

# Install packages from AUR
RUN aurman -S --noconfirm --noedit hmat-oss python-sphinx-gallery python-joblib python-dill cminpack ceres-solver dlib coin-or-bonmin highs pagmo spectra nanoflann libcuba
