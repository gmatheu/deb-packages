FROM ubuntu:14.04
MAINTAINER Gonzalo Matheu <gonzalommj@gmail.com>

RUN apt-get update && apt-get install -y git build-essential libssl-dev
RUN mkdir /workspace
RUN mkdir /output

WORKDIR /workspace

ENV BRANCH master
CMD git clone -b $BRANCH https://github.com/AGWA/git-crypt.git .; \
      make; \
      cp git-crypt /output;
