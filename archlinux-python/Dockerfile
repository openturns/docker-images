# ArchLinux image with Python dependencies

FROM openturns/archlinux-base
MAINTAINER jschueller

# Install some useful packages
RUN sudo pacman -Syu --noconfirm --noprogressbar openssh libxml2 boost tbb r muparser nlopt hdf5 \
      python-numpydoc python-pip python-scipy python-pandas python-sphinx python-matplotlib texlive-latexextra

# Install packages from AUR
RUN aurman -S --noconfirm --noedit hmat-oss16 python-sphinx-gallery python-chaospy python-dill cminpack ceres-solver dlib coin-or-bonmin spectra

# pin pango
RUN sudo pacman -U --noconfirm https://archive.archlinux.org/packages/p/pango/pango-1:1.48.5-1-x86_64.pkg.tar.zst && sudo sed -i "s|IgnorePkg = |IgnorePkg = pango |g" /etc/pacman.conf && cat /etc/pacman.conf|grep IgnorePkg
