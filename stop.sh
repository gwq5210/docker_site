#!/bin/sh

cd `dirname "$0"`

docker-compose stop $@
# docker stack rm docker_site