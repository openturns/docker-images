# ArchLinux image to compile openturns modules

FROM openturns/archlinux-base
RUN sudo pacman -Syu --noconfirm --noprogressbar python-numpydoc python-sphinx python-sphinx-copybutton python-matplotlib python-pip python-pytest texlive-latexextra fftw lcov cgal qhull cddlib

# Install packages from AUR
RUN yay -Syu --noconfirm openturns agrum python-sphinx-gallery libmixmod vinecopulib coacd

RUN sudo pacman -U https://archive.archlinux.org/packages/t/texlive-bin/texlive-bin-2026.0-1-x86_64.pkg.tar.zst --noconfirm
