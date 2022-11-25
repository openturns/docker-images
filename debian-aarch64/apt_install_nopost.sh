#!/bin/sh

set -e
cd /tmp
for pkg in $@
do
  pkgname=`echo ${pkg} | cut -d ":" -f1`
  arch=`echo ${pkg} | cut -d ":" -f2`
  apt-get download ${pkgname}:${arch} python3-minimal:${arch}
  dpkg --unpack ${pkgname}_*_${arch}.deb
  rm -f /var/lib/dpkg/info/${pkgname}.postinst
  rm -f /var/lib/dpkg/info/python3.prerm
  dpkg --configure ${pkgname}:${arch}
done
