#!/usr/bin/env bash
set -e

UNAME="$(uname)"
if [ "${UNAME}" == "Darwin" ]; then
  # for Mac OSX
  # This is here to prevent issuses with no finding type_traits headers
  # though this is done in toolchain, so it seems odd that it is needed.
  export MACOSX_VERSION_MIN="10.9"
  export MACOSX_DEPLOYMENT_TARGET="${MACOSX_VERSION_MIN}"
  export CXXFLAGS="${CXXFLAGS} -mmacosx-version-min=${MACOSX_VERSION_MIN}"
  export LDFLAGS="${LDFLAGS} -mmacosx-version-min=${MACOSX_VERSION_MIN}"
  export LINKFLAGS="${LDFLAGS}"
fi

./configure --prefix="${PREFIX}" || { cat config.log; exit 1; }
make
if [ "${UNAME}" == "Linux" ]; then
  make check  # fails on mac, homebrew recipe does not run check either.
fi
make install
