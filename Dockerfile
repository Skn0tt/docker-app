FROM busybox AS build-env

RUN wget https://github.com/docker/app/releases/download/v0.6.0/docker-app-linux.tar.gz

FROM docker/compose:1.22.0

# docker-app
COPY --from=build-env docker-app-linux.tar.gz .
RUN tar xf docker-app-linux.tar.gz
RUN rm docker-app-linux.tar.gz
RUN cp docker-app-linux /usr/local/bin/docker-app
RUN rm docker-app-linux

ENTRYPOINT ["/bin/sh", "-c"]
