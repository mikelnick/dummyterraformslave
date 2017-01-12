FROM hashicorp/terraform

RUN addgroup dockerslave && adduser -s /bin/bash -D -G dockerslave dockerslave && \
    echo dockerslave | passwd -d dockerslave

RUN apk add --no-cache alpine-sdk bash bash-doc bash-completion wget tar bzip2 openjdk8 git openssh

EXPOSE 22

COPY entry.sh /entry.sh
RUN chmod +x /entry.sh

ENTRYPOINT ["/entry.sh"]

CMD ["/usr/sbin/sshd", "-D", "-f", "/etc/ssh/sshd_config"]