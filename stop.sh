#!/bin/sh

cd `dirname "$0"`

# docker-compose --compatibility stop $@
docker stack rm docker_site
