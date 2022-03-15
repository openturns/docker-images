# ArchLinux image with compatibility for linux 4.x hosts

FROM archlinux:base-devel
MAINTAINER jschueller

# re-include locale files
RUN sed -i -e "s|NoExtract   =|#NoExtract   =|g" -e "s|NoExtract  = usr/share/locale|#NoExtract  = usr/share/locale|g" /etc/pacman.conf && grep NoExtract /etc/pacman.conf

# Update base system
RUN pacman-key --init && pacman-key --populate \
 && pacman -Syu --noconfirm --noprogressbar pacman \
 && pacman-db-upgrade \
 && pacman -Su --noconfirm --noprogressbar ca-certificates \
 && trust extract-compat \
 && pacman -Syyu --noconfirm --noprogressbar git zip swig cmake \
 && pacman -Scc --noconfirm

# Add devel user to build packages
RUN useradd -m -d /home/devel -u 1000 -U -G users,tty -s /bin/bash devel
RUN echo 'devel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER devel
ENV TERM=dumb MAKEFLAGS="-j8"
RUN git config --global user.email devel@a.b && git config --global user.name devel

# Install AUR helper
RUN git clone https://aur.archlinux.org/aurman.git /tmp/aurman && cd /tmp/aurman \
 && makepkg -sfi --skippgpcheck --noconfirm && rm -r /tmp/aurman \
 && mkdir -p ~/.config/aurman/ && echo -e "[miscellaneous]\nskip_news\nskip_new_locations\nno_sudo_loop" > ~/.config/aurman/aurman_config

# Configure pacman to drop cache
RUN aurman -Syu --noconfirm --noedit --pgp_fetch paccache-hook && sudo sed -i "s|installed_keep=2|installed_keep=0|g" /etc/paccache-hook.conf
