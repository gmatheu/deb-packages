#! /bin/bash -e
set -e

function you_need {
  which $1 || {
    echo "You need $1"
    exit 1
  }
}
you_need "wget"

build() {
  VERSION=$1
  BITS=x86_64
  ARCH=linux-$BITS
  TMP=./tmp-$VERSION
  PACKAGE=phantomjs
  DEST=$TMP/opt/$PACKAGE
  DEB=${PACKAGE}_${VERSION}_${ARCH}.deb
  NAME=${PACKAGE}-${VERSION}-${ARCH}
  FILE=${NAME}.tar.bz2
  LINK=$TMP/usr/local/bin/$PACKAGE

  echo "Downloading ${PHANTOMJS} $VERSION for $ARCH"

  wget -nc https://bitbucket.org/ariya/phantomjs/downloads/${FILE} -O ${FILE} || echo "Already downloaded"
  mkdir --parents $DEST
  tar -xf $FILE -C $DEST --strip-components=2 ${NAME}/bin/${PACKAGE}
  mkdir --parents $TMP/usr/local/bin
  chmod a+x $DEST/${PACKAGE}
  ln -sf /opt/${PACKAGE}/${PACKAGE} $LINK

  rm -f $DEB
  fpm -s dir -t deb -C $TMP -n ${PACKAGE} -v $VERSION -a ${BITS} \
    --description "PhantomJS is a headless WebKit scriptable with a JavaScript API. It has fast and native support for various web standards: DOM handling, CSS selector, JSON, Canvas, and SVG." \
    --maintainer "Gonzalo Matheu <gonzalommj@gmail.com>" \
    --provides ${PACKAGE} \
    usr opt

  . ../bintray.sh
  # bintray-create-version
  # bintray-upload
}

build "2.1.1"
