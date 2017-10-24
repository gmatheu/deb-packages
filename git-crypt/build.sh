#! /bin/bash -e

TMP=`pwd`/tmp
BIN=$TMP/usr/local/bin
PACKAGE=git-crypt
VERSION=0.5.0

mkdir -p $BIN
sudo docker build -t $PACKAGE .
sudo docker run -e BRANCH=$VERSION -v $BIN:/output git-crypt

fpm -s dir -t deb -C $TMP -n $PACKAGE -v $VERSION -a amd64 \
  --description "Transparent file encryption in git" \
  --maintainer "Gonzalo Matheu <gonzalommj@gmail.com>" \
  --deb-build-depends "git (>= 1.7.2)" \
  --provides git-crypt \
  usr

DEB="${PACKAGE}_${VERSION}_amd64.deb"
rm -rf $TMP

. ../bintray.sh
bintray-upload
