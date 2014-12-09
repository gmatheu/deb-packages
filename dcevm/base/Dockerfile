FROM ubuntu:14.04 
MAINTAINER Gonzalo Matheu <gonzalommj@gmail.com>

RUN apt-get update
RUN apt-get install -y git mercurial gcc gradle make build-essential openjdk-7-jdk

RUN mkdir /workspace
WORKDIR /workspace
#RUN apt-get download openjdk-7-jdk openjdk-7-jre-headless
#RUN dpkg-deb -x openjdk-7-jdk_7*.deb openjdk-7-jdk 
#RUN dpkg-deb -x openjdk-7-jre-headless_7*.deb openjdk-7-jre-headless
RUN apt-get build-dep -y openjdk-7-jdk

RUN git clone https://github.com/dcevm/dcevm.git
ADD hgrc /.hgrc

WORKDIR /workspace/dcevm/
RUN ./gradlew 
RUN ./gradlew -PhotspotTag=jdk7u60-b09 -Pflavor=full patch compileProduct

WORKDIR /workspace 
RUN hg clone http://hg.openjdk.java.net/jdk7u/jdk7u60/ jdk7 

WORKDIR /workspace/jdk7 
RUN hg update -C -r jdk7u60-b09 
RUN sh get_source.sh 
RUN make LANG=C ALT_BOOTDIR=/usr/lib/jvm/java-7-openjdk-amd64 all 

WORKDIR /workspace
