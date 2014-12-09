FROM gmatheu/dcevm-base
MAINTAINER Gonzalo Matheu <gonzalommj@gmail.com>

WORKDIR /workspace
ADD deb /workspace/dcevm-7-jdk
RUN cp -r jdk7/build/linux-amd64/j2sdk-server-image/* dcevm-7-jdk/usr/lib/jvm/java-7-dcevm-amd64/
RUN find ./dcevm-7-jdk -name libjvm.so -exec cp dcevm/hotspot/build/product/libjvm.so {} \;
RUN dpkg-deb -b dcevm-7-jdk dcevm-7-jdk_7u60b09-1.0_amd64.deb

WORKDIR /workspace
CMD /workspace/build.sh
