#! /bin/bash -e

TMP=`pwd`/tmp
BIN=$TMP/usr/local/bin
VERSION=0.4.2

mkdir -p $BIN
sudo docker build -t git-crypt .
sudo docker run -e BRANCH=$VERSION -v $BIN:/output git-crypt 

fpm -s dir -t deb -C $TMP -n git-crypt -v $VERSION -a amd64 \
  --description "Transparent file encryption in git" \
  --maintainer "Gonzalo Matheu <gonzalommj@gmail.com>" \
  --deb-build-depends "git (>= 1.7.2)" \
  --provides git-crypt \
  usr 

rm -rf $TMP
