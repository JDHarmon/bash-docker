FROM ubuntu
COPY ca-certificates /usr/share/ca-certificates/sentara/
RUN apt-get update && \
	apt-get install -y man ssh git vim curl
WORKDIR /root
RUN	git config --global user.email ${GIT_EMAIL:-'jdharmon@sentara.com'} && \
	git config --global user.name ${GIT_NAME:-'Jason Harmon'}