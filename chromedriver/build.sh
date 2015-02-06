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
  ARCH=amd$BITS
  TMP=./tmp-$VERSION
  PACKAGE=chromedriver
  DEST=$TMP/opt/$PACKAGE
  DEB=${PACKAGE}_${VERSION}_${ARCH}.deb
  FILE=$PACKAGE_linux$BITS.zip
  LINK=$TMP/usr/local/bin/$PACKAGE

  echo "Downloading chromedriver $VERSION for $ARCH"
  wget -nc http://chromedriver.storage.googleapis.com/$VERSION/$FILE -O $VERSION.zip || echo "Already downloaded"
  mkdir --parents $DEST
  unzip -o $VERSION.zip -d $DEST
  mkdir --parents $TMP/usr/local/bin
  chmod a+x $DEST/chromedriver
  ln -sf /opt/chromedriver/chromedriver $LINK 

  fpm -s dir -t deb -C $TMP -n chromedriver -v $VERSION -a amd64 \
    --description "ChromeDriver is a standalone server which implements WebDriver's wire protocol" \
    --maintainer "Gonzalo Matheu <gonzalommj@gmail.com>" \
    --deb-build-depends "google-chrome-stable (>= 33) | google-chrome-beta (>= 33) | google-chrome-unstable (>= 33)" \
    --provides chromedriver \
    usr opt


  . ../.secrets
  . ../upload-bintray.sh
  upload
}

build "2.10"
build "2.11"
build "2.12"
build "2.13"
build "2.14"
