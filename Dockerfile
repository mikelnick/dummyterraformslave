FROM ubuntu:16.04

RUN mkdir /var/run/sshd

RUN useradd -ms /bin/bash dockerslave
RUN echo "dockerslave:dockerslave" | chpasswd

RUN apt-get update && \
    apt-get -y install wget git unzip openjdk-8-jre openssh-server

RUN cd /var && \
    wget https://releases.hashicorp.com/terraform/0.8.4/terraform_0.8.4_linux_amd64.zip && \
    unzip terraform_0.8.4_linux_amd64.zip

ENV PATH "$PATH:/var/terraform"

EXPOSE 22
