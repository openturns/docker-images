# ArchLinux image with Python dependencies

FROM openturns/archlinux-base
MAINTAINER jschueller

WORKDIR /tmp

RUN sudo pacman -Syu swig python-numpy --noconfirm
RUN sudo pacman -Syu perl perl-capture-tiny perl-datetime perl-devel-cover perl-memory-process perl-gd perl-json-xs --noconfirm
RUN git clone https://github.com/linux-test-project/lcov.git

ADD run.sh /tmp
# RUN /tmp/run.sh

WORKDIR /tmp/lcov
RUN git bisect start v2.2 v2.1
RUN git bisect run /tmp/run.sh

