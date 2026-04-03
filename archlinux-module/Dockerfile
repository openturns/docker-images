# ArchLinux image to compile openturns modules

FROM openturns/archlinux-base
RUN sudo pacman -Syu --noconfirm --noprogressbar python-numpydoc python-sphinx python-sphinx-copybutton python-matplotlib python-pip python-pytest texlive-latexextra fftw lcov cgal qhull cddlib

# prevent dlib-cuda to replace dlib
RUN echo -e '[options]\nIgnorePkg = dlib' | sudo tee -a /etc/pacman.conf

# Install packages from AUR
RUN yay -Syu --noconfirm openturns agrum python-sphinx-gallery libmixmod vinecopulib
