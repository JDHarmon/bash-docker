FROM ubuntu

ENV DOCKER_VERSION=17.03.1 DOCKER_COMPOSE_VERSION=1.11.2

COPY ca-certificates /usr/share/ca-certificates/sentara/
RUN apt-get update \
 && apt-get install -y  \
    ca-certificates \
    curl \
    git \
    ssh \
    vim \
 && curl -sSL -O https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION}-ce.tgz \
 && tar -xzf docker-${DOCKER_VERSION}-ce.tgz \
 && mv docker/docker /usr/local/bin \
 && rm -r docker* \
 && curl -sSL -o /usr/local/bin/docker-compose \
    https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-Linux-x86_64 \
 && chmod +x /usr/local/bin/docker-compose
WORKDIR /root
RUN git config --global user.email ${GIT_EMAIL:-'jdharmon@sentara.com'} \
 && git config --global user.name ${GIT_NAME:-'Jason Harmon'}
