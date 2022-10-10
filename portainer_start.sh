#!/bin/bash

cd `dirname "$0"`

# docker-compose -f portainer-agent-stack.yml config | docker stack deploy -c - portainer

DOCKER_SITE_KEY_DATA_DIR=$(cat .env | grep "DOCKER_SITE_KEY_DATA_DIR" | egrep -v "^#" | awk -F = '{print $2}')

dir_array=()
dir_array[${#dir_array[@]}]=${DOCKER_SITE_KEY_DATA_DIR}/portainer/data

for dir in ${dir_array[@]};
do
  mkdir -p $dir
done

./stack_deploy.sh portainer portainer-agent-stack.yml
