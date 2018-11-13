FROM debian:stretch

ENV ANSIBLE_VERSION="2.7.*"

RUN set -e;\
  apt-get update;\
  apt-get install \
    build-essential \
    ca-certificates \
    git \
    gnupg \
    gzip \
    python \
    ssh \
  -y;\
  apt-key adv --keyserver=keyserver.ubuntu.com --receive-keys 93C4A3FD7BB9C367;\
  echo 'deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main' | tee -a /etc/apt/sources.list;\
  apt-get update;\
  apt-get install ansible="${ANSIBLE_VERSION}" -y;\
  rm -vfR /var/lib/apt/lists/*;\
  addgroup --system --gid 1000 docker;\
  adduser --home /docker --gecos '' --shell /bin/bash --gid 1000 --system --disabled-login --uid 1000 docker;

USER docker
WORKDIR /docker
