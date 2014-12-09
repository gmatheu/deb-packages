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
you_need "unzip"

build() {
  VERSION=$1
  BITS=64
  ARCH=amd$BITS
  TMP=./tmp-$VERSION
  DEST=$TMP/opt/chromedriver
  DEB=chromedriver-$VERSION\_$ARCHITECTURE.deb
  FILE=chromedriver_linux$BITS.zip
  LINK=$TMP/usr/local/bin/chromedriver

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
}

build "2.10"
build "2.11"
build "2.12"

# read -p "Bintray Api Key: " BINTRAY_API_KEY
# BINTRAY_USER=gmatheu
# curl -vT $DEB -u$BINTRAY_USER:$BINTRAY_API_KEY  https://api.bintray.com/content/gmatheu/deb/chromedriver/$VERSION/$DEB
# rm -rf ./tmp
# echo 
