#!/bin/bash

cd `dirname "$0"`

# docker-compose --compatibility up -d $@

DOCKER_SITE_KEY_DATA_DIR=$(cat .env | grep "DOCKER_SITE_KEY_DATA_DIR" | egrep -v "^#" | awk -F = '{print $2}')
DOCKER_SITE_DATA_DIR=$(cat .env | grep "DOCKER_SITE_DATA_DIR" | egrep -v "^#" | awk -F = '{print $2}')
DOCKER_SITE_CONF_DIR=$(cat .env | grep "DOCKER_SITE_CONF_DIR" | egrep -v "^#" | awk -F = '{print $2}')
DOCKER_SITE_LOGS_DIR=$(cat .env | grep "DOCKER_SITE_LOGS_DIR" | egrep -v "^#" | awk -F = '{print $2}')
FILE_BROWSER_SHARE_DATA_DIR=$(cat .env | grep "FILE_BROWSER_SHARE_DATA_DIR" | egrep -v "^#" | awk -F = '{print $2}')
TANK_SHARE_DATA_DIR=$(cat .env | grep "TANK_SHARE_DATA_DIR" | egrep -v "^#" | awk -F = '{print $2}')

dir_array=()
dir_array[${#dir_array[@]}]=$FILE_BROWSER_SHARE_DATA_DIR
dir_array[${#dir_array[@]}]=$TANK_SHARE_DATA_DIR
dir_array[${#dir_array[@]}]=${DOCKER_SITE_LOGS_DIR}/nginx
dir_array[${#dir_array[@]}]=${DOCKER_SITE_LOGS_DIR}/mysql
dir_array[${#dir_array[@]}]=${DOCKER_SITE_KEY_DATA_DIR}/mysql
dir_array[${#dir_array[@]}]=${DOCKER_SITE_CONF_DIR}/tank
dir_array[${#dir_array[@]}]=${DOCKER_SITE_LOGS_DIR}/tank
dir_array[${#dir_array[@]}]=${DOCKER_SITE_LOGS_DIR}/v2ray
dir_array[${#dir_array[@]}]=${DOCKER_SITE_CONF_DIR}/filebrowser
dir_array[${#dir_array[@]}]=${DOCKER_SITE_LOGS_DIR}/scrapyd
dir_array[${#dir_array[@]}]=${DOCKER_SITE_DATA_DIR}/scrapyd
dir_array[${#dir_array[@]}]=${DOCKER_SITE_DATA_DIR}/mirai/bots
dir_array[${#dir_array[@]}]=${DOCKER_SITE_DATA_DIR}/mirai/plugins
dir_array[${#dir_array[@]}]=${DOCKER_SITE_LOGS_DIR}/mirai
dir_array[${#dir_array[@]}]=${DOCKER_SITE_CONF_DIR}/mirai
dir_array[${#dir_array[@]}]=${DOCKER_SITE_KEY_DATA_DIR}/elasticsearch/data

for dir in ${dir_array[@]};
do
  mkdir -p $dir
done

chmod 777 ${DOCKER_SITE_KEY_DATA_DIR}/elasticsearch/data

# docker-compose config | docker stack deploy -c - docker_site
./stack_deploy.sh docker_site docker-compose.yml
