#!/bin/bash

cd `dirname "$0"`

# docker-compose --compatibility up -d $@

# docker-compose config | docker stack deploy -c - docker_site
# ./stack_deploy.sh docker_site docker-compose.yml

./compose_deploy.sh docker_compose.yml
