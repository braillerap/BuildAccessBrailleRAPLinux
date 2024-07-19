FROM ubuntu:22.04

#user id and group id as input
ARG UID 
ARG GID

LABEL maintainer="AccessBrailleRAP <pub.sg@free.fr>"

# Fetch build dependencies
RUN DEBIAN_FRONTEND=noninteractive \
    TZ=Europe/Paris  

RUN apt update && \
    apt upgrade -y && \
    apt install -y 

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

#add unprivileged user
RUN addgroup --gid $GID builduser && \
  adduser --uid $UID --gid $GID --disabled-password --gecos "" builduser 

#install tools
RUN apt install  -y cmake build-essential git 
RUN apt install  -y ninja-build
RUN apt install  -y autoconf gnulib

RUN apt install  -y ca-certificates curl gnupg
RUN apt install  -y software-properties-common

RUN apt install  -y python3 
RUN apt install  -y python3-venv 
RUN apt install  -y python3-dev
RUN apt install  -y pkg-config python3-tk python3-gi python3-gi-cairo gir1.2-gtk-3.0 gir1.2-webkit2-4.1

#setup nodejs 
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash -
  RUN apt update
  RUN apt install -y nodejs

#switch to user node
USER builduser

WORKDIR /home/builduser

COPY --chown=builduser:builduser build_accessbraillerap.sh /home/builduser/build_accessbraillerap.sh

RUN git clone --recursive https://github.com/braillerap/AccessBrailleRAP.git AccessBrailleRAP\
  && cd AccessBrailleRAP/ \
  && git checkout main

# exception
COPY --chown=builduser:builduser LinuxAccessBrailleRAP.spec /home/builduser/AccessBrailleRAP/LinuxAccessBrailleRAP.spec
COPY --chown=builduser:builduser reqlinux.txt /home/builduser/AccessBrailleRAP/reqlinux.txt
#  && git checkout $(git describe --tags `git rev-list --tags --max-count=1`)

WORKDIR /home/builduser/AccessBrailleRAP

CMD ["bash", "/home/builduser/build_accessbraillerap.sh"]
