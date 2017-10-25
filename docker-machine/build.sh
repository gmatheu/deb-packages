#! /bin/bash

TMP=`pwd`/tmp
BIN=$TMP/usr/local/bin
PACKAGE=docker-machine
VERSION=0.13.0
ARCH=amd64

mkdir -p $BIN
wget -nc -O ${BIN}/${PACKAGE} -L https://github.com/docker/machine/releases/download/v${VERSION}/docker-machine-`uname -s`-`uname -m`
chmod a+x ${BIN}/${PACKAGE}

DEB="${PACKAGE}_${VERSION}_${ARCH}.deb"
rm -f ${DEB}
fpm -s dir -t deb -C $TMP -n $PACKAGE -v $VERSION -a $ARCH \
  --description "Docker Machine is a tool that lets you install Docker Engine on virtual hosts, and manage the hosts with docker-machine commands." \
  --maintainer "Gonzalo Matheu <gonzalommj@gmail.com>" \
  --provides ${PACKAGE} \
  usr


. ../bintray.sh
bintray-upload

rm -rf $TMP
