FROM alpine

ENV DOCKER_VERSION=17.03.1 DOCKER_COMPOSE_VERSION=1.11.2

COPY ca-certificates /usr/share/ca-certificates/sentara/
RUN apk update \
 && apk add  \
    bash \
    ca-certificates \
    curl \
    git \
    openssh-client \
    vim
WORKDIR /root
COPY root/ /root
RUN set -x \
 && curl -fSL --insecure "https://get.docker.com/builds/`uname -s`/`uname -m`/docker-${DOCKER_VERSION}-ce.tgz" -o docker.tgz \
 && tar -xzvf docker.tgz \
 && mv docker/docker /usr/local/bin/ \
 && rm -rf docker \
 && rm docker.tgz \
 && docker -v
ENV TERM=xterm-256color
RUN git config --global http.sslCAInfo ~/ca-bundle.crt \
 && git config --global user.email ${GIT_EMAIL:-'jdharmon@sentara.com'} \
 && git config --global user.name ${GIT_NAME:-'Jason Harmon'}
CMD ["/bin/bash"]
