# ArchLinux image with Python dependencies

FROM base/archlinux:latest
MAINTAINER jschueller

# Locale
RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Update base system
RUN    pacman -Sy --noconfirm --noprogressbar archlinux-keyring \
    && pacman-key --populate \
    && pacman -Su --noconfirm --noprogressbar pacman \
    && pacman-db-upgrade \
    && pacman -Su --noconfirm --noprogressbar ca-certificates \
    && trust extract-compat \
    && pacman -Syyu --noconfirm --noprogressbar \
    && (echo -e "y\ny\n" | pacman -Scc)

# Install some useful packages to the base system
RUN pacman -Sy --noconfirm --noprogressbar base-devel git sudo gdb wget vim zip openssh libglvnd \
    cmake libxml2 boost intel-tbb doxygen graphviz r swig muparser python-pip python-scipy python-sphinx python-matplotlib ipython pandoc texlive-latexextra

# R-rot
RUN cd /tmp && wget https://github.com/openturns/openturns/raw/1.11/utils/rot_1.4.6.tar.gz && R CMD INSTALL rot_1.4.6.tar.gz

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
 && mkdir -p ~/.config/aurman/ && echo -e "[miscellaneous]\nskip_news\nskip_new_locations" > ~/.config/aurman/aurman_config

# Install packages from AUR
RUN aurman -S --noconfirm --noedit nlopt hmat-oss python-nbsphinx python-numpydoc python-chaospy
