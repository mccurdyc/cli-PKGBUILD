#!/usr/bin/bash

# Usage Function
function usage() {
  cat <<_EOT_
Usage:
  $0 version ...
Description:
  version tells what pkgver to update to
_EOT_
  exit 1
}

if [ $# = 0 ]; then
  usage
fi

newV="$1"
set -e

echo "Processing fastly-bin"
(
  cd fastly-bin || exit
  git clean -fdx
  sed -i "s/pkgver=.*/pkgver=$newV/g" PKGBUILD
  updpkgsums PKGBUILD
  makepkg
  makepkg --printsrcinfo >.SRCINFO
)

echo "Processing fastly-git"
(
  cd fastly-git || exit
  git clean -fdx
  makepkg
  makepkg --printsrcinfo >.SRCINFO
)

# git commit -a -S -m "$newV"
