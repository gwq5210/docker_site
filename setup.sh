#!/bin/sh

cd `dirname "$0"`

./setup_secrets.sh

DOCKER_SITE_KEY_DATA_DIR=$(cat .env | grep "DOCKER_SITE_KEY_DATA_DIR" | egrep -v "^#" | awk -F = '{print $2}')
es_config_dir=${DOCKER_SITE_KEY_DATA_DIR}/elasticsearch/config
kibana_config_dir=${DOCKER_SITE_KEY_DATA_DIR}/kibana/config
mkdir -p $es_config_dir $kibana_config_dir
chmod 777 $es_config_dir $kibana_config_dir

# ./pull_all.sh

docker stack rm setup
docker-compose -f setup-docker-compose.yml config | docker stack deploy -c - setup
