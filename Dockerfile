FROM ubuntu:16.04

RUN useradd -ms /bin/bash dockerslave
RUN echo "dockerslave:dockerslave" | chpasswd

RUN mkdir /var/run/sshd /var/terraform /home/dockerslave/.ssh

RUN apt-get update && \
    apt-get -y install wget git unzip openjdk-8-jre openssh-server

RUN cd /var/terraform && \
    wget https://releases.hashicorp.com/terraform/0.8.4/terraform_0.8.4_linux_amd64.zip && \
    unzip terraform_0.8.4_linux_amd64.zip

RUN touch /home/dockerslave/.ssh/known_hosts

RUN ssh-keyscan -t rsa github.com >> /home/dockerslave/.ssh/known_hosts

RUN echo 'export PATH=/usr/terraform:$PATH' >>/home/dockerslave/.profile

RUN echo 'export PATH=/usr/terraform:$PATH' >>~/.bash_profile

RUN echo 'export PATH=/usr/terraform:$PATH' >>/etc/environment

ENV PATH /var/terraform:$PATH

EXPOSE 22
