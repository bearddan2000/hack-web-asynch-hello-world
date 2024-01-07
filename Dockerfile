# Seems ubuntu dropped the repo after 20.04
FROM ubuntu:20.04

ENV USERNAME developer

WORKDIR /app

RUN apt-get update

RUN apt-get install -y software-properties-common apt-transport-https

RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xB4112585D386EB94

RUN add-apt-repository https://dl.hhvm.com/ubuntu

RUN apt-get update

RUN apt-get install -y hhvm sudo

# create and switch to a user
RUN echo "backus ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN useradd --no-log-init --home-dir /home/$USERNAME --create-home --shell /bin/bash $USERNAME
RUN adduser $USERNAME sudo

WORKDIR /home/$USERNAME

COPY bin .

# This a daemon that watches the filesystem
# Not neccessary for this demo
# RUN hh_client

CMD ""
