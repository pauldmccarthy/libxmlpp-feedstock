#!/usr/bin/env bash
# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* ./build
set -ex

./configure --prefix="${PREFIX}" || { cat config.log; exit 1; }
make
if [[ ${target_platform} == linux-* ]] ; then
  # fails on mac, homebrew recipe does not run check either.
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
  make check
fi
fi
make install

# remove libtool files
find $PREFIX -name '*.la' -delete
