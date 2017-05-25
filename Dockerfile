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
#RUN set -x \
# && curl -fSL "https://get.docker.com/builds/`uname -s`/`uname -m`/docker-${DOCKER_VERSION}-ce.tgz" -o docker.tgz \
# && tar -xzvf docker.tgz \
# && mv docker/* /usr/local/bin/ \
# && rmdir docker \
# && rm docker.tgz \
# && docker -v
#RUN set -x \
# && curl -fSL "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-`uname -s`-`uname -m`" -o /usr/local/bin/docker-compose \
# && chmod +x /usr/local/bin/docker-compose \
# && docker-compose -v
WORKDIR /root
COPY root/ /root
ENV TERM=xterm-256color
RUN git config --global user.email ${GIT_EMAIL:-'jdharmon@sentara.com'} \
 && git config --global user.name ${GIT_NAME:-'Jason Harmon'}
CMD ["/bin/bash"]
