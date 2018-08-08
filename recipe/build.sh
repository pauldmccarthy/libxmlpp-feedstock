#!/usr/bin/env bash
set -ex

UNAME="$(uname)"

./configure --prefix="${PREFIX}" || { cat config.log; exit 1; }
make
if [ "${UNAME}" == "Linux" ]; then
  make check  # fails on mac, homebrew recipe does not run check either.
fi
make install

# remove libtool files
find $PREFIX -name '*.la' -delete
