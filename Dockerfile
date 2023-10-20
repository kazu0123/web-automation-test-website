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

### Install Node.js
RUN apt-get install -y ca-certificates curl gnupg &&\
    mkdir -p /etc/apt/keyrings &&\
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg

ENV NODE_MAJOR=18

RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list &&\
    apt-get update &&\
    apt-get install -y nodejs
