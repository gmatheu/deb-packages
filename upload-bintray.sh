#! /bin/bash

echo -n GPG Passphrase:  
read -s GPG_PASSPHRASE
echo

function upload() {
  URL="https://api.bintray.com/content/$BINTRAY_USER/deb/$PACKAGE/$VERSION/$DEB"
  echo "Uploading $DEB"
  curl -T $DEB -u$BINTRAY_USER:$BINTRAY_API_KEY $URL \
    -H 'X-Bintray-Publish: 1' \
    -H 'X-Bintray-Override: 1' \
    -H "X-GPG-PASSPHRASE: $GPG_PASSPHRASE" 
  echo
}
