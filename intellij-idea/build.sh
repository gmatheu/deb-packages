#! /bin/bash -ex
set -ex

build() {
  VERSION=14
  MINOR_VERSION=.$1
  NAME=ideaIC-$VERSION

  TMP=./tmp
  DEST=$TMP/opt/$NAME
  LINK=$TMP/usr/local/bin/$NAME

  FILE=$NAME$MINOR_VERSION.tar.gz
  URL=http://download-cf.jetbrains.com/idea/$FILE

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

  echo "Downloading $NAME ($VERSION)"
  wget -nc $URL 
  mkdir --parents $DEST
  tar -xf $FILE -C $DEST --strip 1
  mkdir --parents $TMP/usr/local/bin
  ln -sf /opt/$NAME/bin/idea.sh $LINK 
  cp -r template/* $TMP

  fpm -s dir -t deb -C tmp -n idea-ic-14 -v $VERSION$MINOR_VERSION -a all \
    --description "IntelliJ Idea 14 Community Edition" \
    --maintainer "Gonzalo Matheu <gonzalommj@gmail.com>" \
    usr opt
}
build "0.1"
build "0.2"

# read -p "Bintray Api Key: " BINTRAY_API_KEY
# BINTRAY_USER=gmatheu
# curl -vT $DEB -u$BINTRAY_USER:$BINTRAY_API_KEY  https://api.bintray.com/content/gmatheu/deb/firefox-de/$VERSION/$DEB
# # rm -rf $TMP
# echo 
