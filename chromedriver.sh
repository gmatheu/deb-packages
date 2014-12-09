#! /bin/bash -ex
set -ex

VERSION=2.10
BITS=64
ARCH=amd$BITS
DEST=./tmp/opt/chromedriver
DEB=chromedriver-$VERSION\_$ARCHITECTURE.deb
FILE=chromedriver_linux$BITS.zip
LINK=./tmp/usr/local/bin/chromedriver

function you_need {
  which $1 || { 
    echo "You need $1"
    exit 1 
  }
}
you_need "wget"
you_need "curl"
you_need "unzip"

echo "Downloading chromedriver $VERSION for $ARCH"
wget -nc http://chromedriver.storage.googleapis.com/$VERSION/$FILE
mkdir --parents $DEST
unzip -o $FILE -d $DEST
mkdir --parents ./tmp/usr/local/bin
ln -sf /opt/chromedriver/chromedriver $LINK 
chmod +x $LINK

mkdir --parents ./tmp/DEBIAN
cat > ./tmp/DEBIAN/control <<EOF
Package: chromedriver
Version: $VERSION
Architecture: $ARCH
Maintainer: Gonzalo Matheu <gonzalommj@gmail.com>
Installed-Size: 5656
Pre-Depends: multiarch-support
Depends: google-chrome-stable (>= 33) | google-chrome-beta (>= 33) | google-chrome-unstable (>= 33)
Provides: chromedriver
Section:
Priority: optional
Multi-Arch: same
Homepage: https://code.google.com/p/selenium/wiki/ChromeDriver
Description: ChromeDriver is a standalone server which implements WebDriver's wire protocol. 
EOF
dpkg-deb -b ./tmp $DEB 

read -p "Bintray Api Key: " BINTRAY_API_KEY
BINTRAY_USER=gmatheu
curl -vT $DEB -u$BINTRAY_USER:$BINTRAY_API_KEY  https://api.bintray.com/content/gmatheu/deb/chromedriver/$VERSION/$DEB
rm -rf ./tmp
echo 
