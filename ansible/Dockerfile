FROM python:alpine

RUN set -uex  && \
      apk add --update --no-cache \
        bash build-base libffi-dev python3-dev openssh sshpass

RUN set -uex  && \
      pip install ansible

RUN mkdir /root/.ssh

WORKDIR /ansible

ENTRYPOINT [ "ansible-playbook" ]
