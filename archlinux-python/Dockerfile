# ArchLinux image with Python dependencies

FROM openturns/archlinux-base
MAINTAINER jschueller

WORKDIR /tmp

RUN sudo pacman -Syu swig python-numpy --noconfirm
RUN sudo pacman -Syu perl perl-capture-tiny perl-datetime perl-devel-cover perl-memory-process perl-gd perl-json-xs --noconfirm
RUN git clone --depth 150 https://github.com/linux-test-project/lcov.git && cd lcov && sudo make PREFIX="/usr" CFG_DIR=/etc install
RUN genhtml --version

ADD run.sh /tmp
RUN /tmp/run.sh

