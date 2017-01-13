FROM ubuntu:16.04

RUN apt-get update && \
    apt-get -y install wget git unzip openjdk-8-jre openssh-server

RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd

RUN mkdir /var/run/sshd /var/terraform
RUN adduser --quiet jenkins
RUN echo "jenkins:jenkins" | chpasswd

RUN chown -R jenkins /var/terraform

USER jenkins

RUN mkdir /home/jenkins/.ssh

RUN cd /var/terraform && \
    wget https://releases.hashicorp.com/terraform/0.8.4/terraform_0.8.4_linux_amd64.zip && \
    unzip terraform_0.8.4_linux_amd64.zip

RUN touch /home/jenkins/.ssh/known_hosts

RUN ssh-keyscan github.com >> /home/jenkins/.ssh/known_hosts

EXPOSE 22

USER root

ENV PATH /var/terraform:$PATH

CMD ["/usr/sbin/sshd", "-D"]