FROM alpine

ENV DOCKER_VERSION=17.03.1 DOCKER_COMPOSE_VERSION=1.11.2 GLIBC_VERSION=2.25-r0

COPY ca-certificates /usr/local/share/ca-certificates/
RUN apk update \
 && apk add  \
    bash \
    bash-completion \
    ca-certificates \
    coreutils \
    curl \
    git \
    less \
    openssh-client \
    vim
WORKDIR /root
COPY root/ /root

# Install glibc, Docker, and Docker Compose
RUN set -x \
 && curl -sSL -o /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub \
 && curl -sSL -O "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk" \
 && curl -sSL -O "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk" \
 && apk add glibc-${GLIBC_VERSION}.apk glibc-bin-${GLIBC_VERSION}.apk \
 && rm glibc*.apk \
 && curl -sSL "https://get.docker.com/builds/`uname -s`/`uname -m`/docker-${DOCKER_VERSION}-ce.tgz" -o docker.tgz \
 && tar -xzvf docker.tgz \
 && mv docker/docker /usr/local/bin/ \
 && rm -rf docker \
 && rm docker.tgz \
 && docker -v \
 && curl -sSL "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-`uname -s`-`uname -m`" -o /usr/local/bin/docker-compose \
 && chmod +x /usr/local/bin/docker-compose \
 && docker-compose -v 
 
RUN git config --global user.email ${GIT_EMAIL:-'jdharmon@sentara.com'} \
 && git config --global user.name ${GIT_NAME:-'Jason Harmon'}

CMD ["/bin/bash"]
