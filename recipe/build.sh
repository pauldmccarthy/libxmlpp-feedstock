#!/usr/bin/env bash
set -ex

./configure --prefix="${PREFIX}" || { cat config.log; exit 1; }
make
if [[ ${target_platform} == linux-* ]] ; then
  # fails on mac, homebrew recipe does not run check either.
  make check
fi
make install

# remove libtool files
find $PREFIX -name '*.la' -delete
