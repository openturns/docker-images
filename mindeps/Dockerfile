FROM debian:11

RUN printf '%s\n' \
  'deb http://snapshot.debian.org/archive/debian/20260701T000000Z bullseye main' \
  'deb http://snapshot.debian.org/archive/debian/20260701T000000Z bullseye-updates main' \
  'deb http://snapshot.debian.org/archive/debian-security/20260701T000000Z bullseye-security main' > /etc/apt/sources.list \
 && printf 'Acquire::Check-Valid-Until "false";\n' > /etc/apt/apt.conf.d/99snapshot

RUN apt-get -y update && apt-get -y install git g++ python3-matplotlib libxml2-dev liblapack-dev cmake swig python3-dev libcminpack-dev libboost-math-dev
