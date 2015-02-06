#! /bin/bash

function upload() {
  URL="https://api.bintray.com/content/$BINTRAY_USER/deb/$PACKAGE/$VERSION/$DEB"
  curl -vT $DEB -u$BINTRAY_USER:$BINTRAY_API_KEY $URL
}
