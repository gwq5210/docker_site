#!/bin/bash

cd `dirname "$0"`

DOCKER_SITE_KEY_DATA_DIR=$(cat .env | grep "DOCKER_SITE_KEY_DATA_DIR" | egrep -v "^#" | awk -F = '{print $2}')
DOCKER_SITE_BACKUP_DIR=$(cat .env | grep "DOCKER_SITE_BACKUP_DIR" | egrep -v "^#" | awk -F = '{print $2}')

dir_array=()
dir_array[${#dir_array[@]}]=${DOCKER_SITE_KEY_DATA_DIR}/portainer/data
dir_array[${#dir_array[@]}]=${DOCKER_SITE_BACKUP_DIR}/portainer

for dir in ${dir_array[@]};
do
  mkdir -p $dir
done

./compose_deploy.sh portainer.yml $*
