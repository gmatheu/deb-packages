build: base
	sudo docker build -t gmatheu/dcevm-openjdk7 .

jdk7: base
	sudo docker build -t gmatheu/dcevm-jdk7 jdk7

jre7: base
	sudo docker build -t gmatheu/dcevm-jre7 jre7

base:
	sudo docker build -t gmatheu/dcevm-base base

run:
	sudo docker run -it --rm gmatheu/dcevm-base /bin/bash 

run-jre7:
	sudo docker run -it --rm -v `pwd`:/shared gmatheu/dcevm-jre7 /bin/bash 

download:
	apt-get download openjdk-7-jdk openjdk-7-jre-headless
	dpkg-deb -e openjdk-7-jdk_7*.deb jdk7/deb/DEBIAN
	dpkg-deb -e openjdk-7-jre-headless_7*.deb dcevm-7-jre-headless/DEBIAN
	dpkg-deb -x openjdk-7-jdk_7*.deb jdk7/deb
	mv jdk7/deb/usr/lib/jvm/java-7-openjdk-amd64/ jdk7/deb/usr/lib/jvm/java-7-dcevm-amd64

.PHONY: build base run

