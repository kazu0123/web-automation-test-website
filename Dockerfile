FROM ubuntu:jammy

# Install basic development tools
RUN apt-get update &&\
    apt-get upgrade -y &&\
    apt-get install -y git sudo mysql-client

ARG HOST_UID
ARG USERNAME=vscode
### Create 'vscode' user with sudo access.
RUN adduser --uid ${HOST_UID} ${USERNAME}
RUN echo ${USERNAME} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${USERNAME} &&\
    chmod 0440 /etc/sudoers.d/${USERNAME}
