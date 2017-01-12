FROM hashicorp/terraform

RUN adduser dockerslave
RUN echo dockerslave | passwd -d jenkins-slave

RUN apk add --no-cache alpine-sdk bash bash-doc bash-completion wget tar bzip2 openjdk8 git openssh

EXPOSE 22

COPY entry.sh /entry.sh
RUN chmod +x /entry.sh

ENTRYPOINT ["/entry.sh"]

CMD ["/usr/sbin/sshd", "-D", "-f", "/etc/ssh/sshd_config"]