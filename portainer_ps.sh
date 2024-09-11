#!/bin/sh

cd `dirname "$0"`

docker-compose --compatibility -f portainer.yml ps $@
