FROM ubuntu:22.04

RUN apt-get update

RUN apt-get install -y build-essential python3 python3.10-venv sshpass rsync

COPY . /app

WORKDIR /app

ENV ANSIBLE_HOST_KEY_CHECKING=false

CMD ["/bin/bash"]
