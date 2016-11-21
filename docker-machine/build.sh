#! /bin/sh

TMP=`pwd`/tmp
BIN=$TMP/usr/local/bin
PACKAGE=docker-machine
VERSION=0.8.2
ARCH=`uname -m`

mkdir -p $BIN
wget -O ${BIN}/${PACKAGE} -L https://github.com/docker/machine/releases/download/v${VERSION}/docker-machine-`uname -s`-${ARCH}
chmod a+x ${BIN}/${PACKAGE}

DEB="${PACKAGE}_${VERSION}_${ARCH}.deb"
rm -f ${DEB}
fpm -s dir -t deb -C $TMP -n $PACKAGE -v $VERSION -a $ARCH \
  --description "Docker Machine is a tool that lets you install Docker Engine on virtual hosts, and manage the hosts with docker-machine commands." \
  --maintainer "Gonzalo Matheu <gonzalommj@gmail.com>" \
  --provides ${PACKAGE} \
  usr

rm -rf $TMP

