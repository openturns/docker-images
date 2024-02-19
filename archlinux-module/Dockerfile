# ArchLinux image to compile openturns modules

FROM openturns/archlinux-base
MAINTAINER jschueller

# Install some useful packages
RUN sudo pacman -Syu --noconfirm --noprogressbar python-numpydoc python-sphinx python-matplotlib python-pip texlive-latexextra

# Install packages from AUR
RUN aurman -Syu --noconfirm --noedit --pgp_fetch openturns agrum python-sphinx-gallery fftw libmixmod lcov
RUN aurman -Syu --noconfirm --noedit --pgp_fetch cython0 python-pyfmi python-pythonfmu python-fmpy-sundials6 openmodelica-omlibraries jdk-openjdk python-pytest python-sphinxcontrib-bibtex python-sphinx-renku-theme
