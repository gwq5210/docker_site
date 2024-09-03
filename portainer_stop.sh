#!/bin/sh

cd `dirname "$0"`

docker-compose -f portainer-agent.yml stop $@
