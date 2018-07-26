FROM node:9.11.2 AS build-env

COPY get-latest-version.js .
RUN node get-latest-version.js
RUN export VERSION=$(node get-latest-version.js); wget https://github.com/docker/app/releases/download/$VERSION/docker-app-linux.tar.gz

FROM docker

# docker-app
COPY --from=build-env docker-app-linux.tar.gz .
RUN tar xf docker-app-linux.tar.gz
RUN rm docker-app-linux.tar.gz
RUN cp docker-app-linux /usr/local/bin/docker-app
RUN rm docker-app-linux

# docker-compose
RUN sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
RUN sudo chmod +x /usr/local/bin/docker-compose
