# ArchLinux image with Python dependencies

FROM openturns/archlinux-base

# Install some useful packages
RUN sudo pacman -Syu --noconfirm --noprogressbar openssh libxml2 boost tbb muparser nlopt hdf5 primesieve mold lcov \
      python-numpydoc python-pip python-scipy python-pandas python-sphinx python-sphinx-copybutton python-sphinxcontrib-jquery python-matplotlib texlive-latexextra texlive-mathscience

# Install packages from AUR
RUN yay -S --noconfirm hmat-oss python-sphinx-gallery python-joblib python-dill cminpack ceres-solver-lgpl dlib coin-or-bonmin highs pagmo spectra nanoflann libcuba

#RUN cd /tmp && sudo pacman -S python-lxml autoconf-archive --noconfirm && rm -rf dvisvgm && git clone --depth 1 https://gitlab.archlinux.org/archlinux/packaging/packages/dvisvgm.git && cd dvisvgm && sed -i 's|./configure|CXXFLAGS="\${CXXFLAGS} -std=c++17" ./configure|g' PKGBUILD && makepkg && sudo pacman -U dvisvgm*.zst --noconfirm

RUN sudo pacman -U https://archive.archlinux.org/packages/t/texlive-bin/texlive-bin-2026.0-1-x86_64.pkg.tar.zst --noconfirm
