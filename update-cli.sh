#!/usr/bin/bash

# Usage Function
function usage() {
  cat <<EOT
Usage:
  $0 version ...
Description:
  version tells what pkgver to update to
EOT
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
  # git checkout .
  git clean -fdx
  # git pull
  sed -i "s/pkgver=.*/pkgver=$newV/g" PKGBUILD
  updpkgsums PKGBUILD
  makepkg
  makepkg --printsrcinfo >.SRCINFO
  #git commit -a -S -m "$newV"
  #git push
)

echo "Processing fastly-git"
(
  cd fastly-git || exit
  # git checkout .
  sudo git clean -fdx
  # git pull
  makepkg
  makepkg --printsrcinfo >.SRCINFO
  #git push
)

# git commit -a -S -m "$newV"
