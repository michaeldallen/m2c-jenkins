FROM ubuntu:bionic
RUN apt-get update && apt-get -y dist-upgrade
RUN apt-get install --assume-yes \
  make \
  bsdmainutils curl


RUN curl -fsSL https://get.docker.com -o /tmp/get-docker.sh
RUN sh /tmp/get-docker.sh

RUN apt-get update && apt-get upgrade -yz
