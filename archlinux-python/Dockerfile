# ArchLinux image with Python dependencies

FROM archlinux/base
MAINTAINER jschueller

# Locale
RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Update base system
RUN pacman-key --init && pacman-key --populate \
    && pacman -Syu --noconfirm --noprogressbar pacman \
    && pacman-db-upgrade \
    && pacman -Su --noconfirm --noprogressbar ca-certificates \
    && trust extract-compat \
    && pacman -Syyu --noconfirm --noprogressbar \
    && pacman -Scc --noconfirm

# Install some useful packages to the base system
RUN pacman -Sy --noconfirm --noprogressbar base-devel git sudo zip libglvnd openssh \
    cmake libxml2 boost tbb doxygen graphviz r swig muparser nlopt hdf5 python-numpydoc python-pip python-scipy python-pandas python-sphinx python-matplotlib ipython pandoc texlive-latexextra

# Add devel user to build packages
RUN useradd -m -d /home/devel -u 1000 -U -G users,tty -s /bin/bash devel
RUN echo 'devel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER devel
ENV TERM dumb
ENV MAKEFLAGS "-j8"
RUN git config --global user.email devel@a.b && git config --global user.name devel

# Install AUR helper
RUN git clone https://aur.archlinux.org/aurman.git /tmp/aurman && cd /tmp/aurman \
 && makepkg -sfi --skippgpcheck --noconfirm \
 && mkdir -p ~/.config/aurman/ && echo -e "[miscellaneous]\nskip_news\nskip_new_locations\nno_sudo_loop" > ~/.config/aurman/aurman_config

# Install packages from AUR
RUN aurman -S --noconfirm --noedit hmat-oss python-nbsphinx python-sphinx-gallery python-chaospy cminpack ceres-solver dlib coin-or-bonmin spectra
