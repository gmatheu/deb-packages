#! /bin/bash -ex

cd /workspace/dcevm 
./gradlew -PhotspotTag=jdk7u60-b09 -Pflavor=full patch compileProduct

cd /workspace 
hg clone http://hg.openjdk.java.net/jdk7u/jdk7u60/ jdk7 
cd jdk7 
hg update -C -r jdk7u60-b09 
sh get_source.sh 
make LANG=C ALT_BOOTDIR=/usr/lib/jvm/java-7-openjdk-amd64 all 
find ./build -name libjvm.so -ok cp /workspace/dcevm/hotspot/build/product/libjvm.so {} \;

cd /workspace
# mkdir -p dcevm-7-jdk/usr/lib/jvm/java-7-dcevm-amd64/
cp -r jdk7u60/build/linux-amd64/j2sdk-server-image/* dcevm-7-jdk/usr/lib/jvm/java-7-dcevm-amd64/
# dpkg-deb -e openjdk-7-jdk_7u65-2.5.2-3~14.04_amd64.deb dcevm-7-jdk/DEBIAN
dpkg-deb -b dcevm-7-jdk dcevm-7-jdk_7u60b09-1.0_amd64.deb

read -p "Bintray Api Key: " BINTRAY_API_KEY
curl -vT dcevm-7-jre_7u60b09-1.0_amd64.deb -ugmatheu:$BINTRAY_API_KEY  https://api.bintray.com/content/gmatheu/deb/dcevm-7-jre/7u60b09-1.0/dcevm-7-jre_7u60b09-1.0_amd64.deb
echo "deb http://dl.bintray.com/gmatheu/deb /" | sudo tee -a /etc/apt/sources.list
apt-get update
