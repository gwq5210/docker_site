#!/bin/sh

cd `dirname "$0"`

docker-compose -f portainer-agent-stack.yml config | docker stack deploy -c - portainer
