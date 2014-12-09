#! /bin/bash -ex
set -ex

function you_need {
  which $1 || { 
    echo "You need $1"
    exit 1 
  }
}
you_need "wget"
you_need "curl"
you_need "tar"
you_need "fpm"

build() {
  VERSION=$1
  BITS=64
  ARCH=amd$BITS
  TMP=./tmp-$VERSION
  DEST=$TMP/opt/firefox-de
  DEB=firefox-de-$VERSION\_$ARCHITECTURE.deb
  LINK=$TMP/usr/local/bin/firefox-de

  FILE=firefox-$VERSION.en-US.linux-x86_64.tar.bz2
  URL=https://download-installer.cdn.mozilla.net/pub/firefox/nightly/latest-mozilla-aurora/$FILE

  echo "Downloading Firefox DE $VERSION for $ARCH"
  wget -nc $URL 
  mkdir --parents $DEST
  tar -xf $FILE -C $DEST --strip 1
  mkdir --parents $TMP/usr/local/bin
  ln -sf /opt/firefox-de/firefox $LINK 
  cp -r template/* $TMP

  fpm -s dir -t deb -C $TMP -n firefox-de -v $VERSION -a amd64 \
    --description "Firefox Developer Edition" \
    --maintainer "Gonzalo Matheu <gonzalommj@gmail.com>" \
    usr opt
}

build "35.0a2"  
build "36.0a2"  

# read -p "Bintray Api Key: " BINTRAY_API_KEY
# BINTRAY_USER=gmatheu
# curl -vT $DEB -u$BINTRAY_USER:$BINTRAY_API_KEY  https://api.bintray.com/content/gmatheu/deb/firefox-de/$VERSION/$DEB
# # rm -rf $TMP
# echo 
