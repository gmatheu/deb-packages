FROM gmatheu/dcevm-base
MAINTAINER Gonzalo Matheu <gonzalommj@gmail.com>

WORKDIR /workspace
ADD deb /workspace/dcevm-7-jre
RUN cp -nr jdk7/build/linux-amd64/j2re-image/* dcevm-7-jre/usr/lib/jvm/java-7-dcevm-amd64/jre || echo "SHOULD SOLVE DANGLING LINKS ISSUE"
RUN find ./dcevm-7-jre -name libjvm.so -exec cp dcevm/hotspot/build/product/libjvm.so {} \;
RUN find ./dcevm-7-jre -name libjvm.diz -delete
RUN dpkg-deb -b dcevm-7-jre dcevm-7-jre_7u60b09-1.0_amd64.deb

WORKDIR /workspace
