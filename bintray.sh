#! /bin/bash

function bintray-upload() {
  URL="https://api.bintray.com/content/$BINTRAY_USER/deb/$PACKAGE/$VERSION/$DEB"
  echo "Uploading $DEB"
  curl -v --progress-bar -T $DEB -u$BINTRAY_USER:$BINTRAY_TOKEN $URL \
    -H 'X-Bintray-Publish: 1' \
    -H 'X-Bintray-Override: 1' \
		-H 'X-Bintray-Debian-Distribution: stable' \
		-H 'X-Bintray-Debian-Component: contrib' \
		-H 'X-Bintray-Debian-Architecture: amd64'
  echo
}

function bintray-create-version() {
  URL="https://api.bintray.com/packages/$BINTRAY_USER/deb/$PACKAGE/versions"
  echo "Creating version $VERSION for $PACKAGE"
  curl -v -u$BINTRAY_USER:$BINTRAY_TOKEN $URL \
       -d "{ \"name\": \"$VERSION\" }"
  echo
}
