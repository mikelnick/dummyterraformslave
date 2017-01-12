FROM ubuntu:16.04

RUN useradd -ms /bin/bash dockerslave
RUN echo "dockerslave:dockerslave" | chpasswd

RUN apt-get wget unzip openjdk8 git openssh

RUN cd /var && \
    wget https://releases.hashicorp.com/terraform/0.8.4/terraform_0.8.4_linux_amd64.zip && \
    unzip terraform_0.8.4_linux_amd64.zip

ENV PATH "$PATH:/var/terraform"

EXPOSE 22
