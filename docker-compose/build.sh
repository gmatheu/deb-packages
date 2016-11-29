#! /bin/sh

TMP=`pwd`/tmp
BIN=$TMP/usr/local/bin
PACKAGE=docker-compose
VERSION=1.8.1
ARCH=`uname -m`
KERNEL=`uname -s`

mkdir -p $BIN
wget -O ${BIN}/${PACKAGE} -L https://github.com/docker/compose/releases/download/${VERSION}/docker-compose-${KERNEL}-${ARCH}
chmod a+x ${BIN}/${PACKAGE}

DEB="${PACKAGE}_${VERSION}_${ARCH}.deb"
rm -f ${DEB}
fpm -s dir -t deb -C $TMP -n $PACKAGE -v $VERSION -a $ARCH \
  --description "Compose is a tool for defining and running multi-container Docker applications. With Compose, you use a Compose file to configure your application’s services." \
  --maintainer "Gonzalo Matheu <gonzalommj@gmail.com>" \
  --provides ${PACKAGE} \
  usr

rm -rf $TMP

