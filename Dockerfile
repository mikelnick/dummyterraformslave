FROM ubuntu:16.04

RUN mkdir /var/run/sshd /var/terraform

RUN useradd -ms /bin/bash dockerslave
RUN echo "dockerslave:dockerslave" | chpasswd

RUN apt-get update && \
    apt-get -y install wget git unzip openjdk-8-jre openssh-server

RUN cd /var/terraform && \
    wget https://releases.hashicorp.com/terraform/0.8.4/terraform_0.8.4_linux_amd64.zip && \
    unzip terraform_0.8.4_linux_amd64.zip

RUN chown -R dockerslave /var/terraform

USER dockerslave
ENV PATH /var/terraform:$PATH

USER root
EXPOSE 22
