#! /bin/bash -e
set -e

function you_need {
  which $1 || {
    echo "You need $1"
    exit 1
  }
}
you_need "wget"
you_need "curl"
you_need "unzip"

build() {
  VERSION=$1
  BITS=64
  ARCH=linux$BITS
  TMP=./tmp-$VERSION
  PACKAGE=geckodriver
  DEST=$TMP/opt/$PACKAGE
  DEB=${PACKAGE}_${VERSION}_${ARCH}.deb
  FILE=${PACKAGE}-v${VERSION}-${ARCH}.tar.gz
  LINK=$TMP/usr/local/bin/$PACKAGE

  echo "Downloading geckodriver $VERSION for $ARCH"

  wget -nc https://github.com/mozilla/geckodriver/releases/download/v${VERSION}/${FILE} -O ${FILE} || echo "Already downloaded"
  mkdir --parents $DEST
  tar -xf $FILE -C $DEST
  mkdir --parents $TMP/usr/local/bin
  chmod a+x $DEST/${PACKAGE}
  ln -sf /opt/${PACKAGE}/${PACKAGE} $LINK

  rm -f $DEB
  fpm -s dir -t deb -C $TMP -n ${PACKAGE} -v $VERSION -a amd${BITS} \
    --description "Proxy for using W3C WebDriver-compatible clients to interact with Gecko-based browsers." \
    --maintainer "Gonzalo Matheu <gonzalommj@gmail.com>" \
    --provides ${PACKAGE} \
    usr opt

  . ../bintray.sh
  # bintray-create-version
  # bintray-upload
}

build "0.13.0"
