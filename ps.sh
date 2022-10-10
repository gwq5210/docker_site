#!/bin/sh

cd `dirname "$0"`

# docker-compose --compatibility ps $@
docker stack services docker_site
