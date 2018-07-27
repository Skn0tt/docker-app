#!/bin/sh

CMD=$1
shift
IMAGE=$1
shift
SET=$@

docker-app render $IMAGE $SET | docker-compose -f - $CMD -d
