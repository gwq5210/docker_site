#!/bin/sh

cd `dirname "$0"`

# ./pull_all.sh

docker stack rm setup_certs
./stack_deploy.sh setup_certs setup-certs-docker-compose.yml

./setup_secrets.sh

DOCKER_SITE_KEY_DATA_DIR=$(cat .env | grep "DOCKER_SITE_KEY_DATA_DIR" | egrep -v "^#" | awk -F = '{print $2}')
DOCKER_SITE_DATA_DIR=$(cat .env | grep "DOCKER_SITE_DATA_DIR" | egrep -v "^#" | awk -F = '{print $2}')
DOCKER_SITE_CONF_DIR=$(cat .env | grep "DOCKER_SITE_CONF_DIR" | egrep -v "^#" | awk -F = '{print $2}')
DOCKER_SITE_LOGS_DIR=$(cat .env | grep "DOCKER_SITE_LOGS_DIR" | egrep -v "^#" | awk -F = '{print $2}')
FILE_BROWSER_SHARE_DATA_DIR=$(cat .env | grep "FILE_BROWSER_SHARE_DATA_DIR" | egrep -v "^#" | awk -F = '{print $2}')
TANK_SHARE_DATA_DIR=$(cat .env | grep "TANK_SHARE_DATA_DIR" | egrep -v "^#" | awk -F = '{print $2}')
DOCKER_SITE_BACKUP_DIR=$(cat .env | grep "DOCKER_SITE_BACKUP_DIR" | egrep -v "^#" | awk -F = '{print $2}')
es_config_dir=${DOCKER_SITE_KEY_DATA_DIR}/elasticsearch/config
kibana_config_dir=${DOCKER_SITE_KEY_DATA_DIR}/kibana/config
mkdir -p $es_config_dir $kibana_config_dir
chmod 777 $es_config_dir $kibana_config_dir

dir_array=()
dir_array[${#dir_array[@]}]=$FILE_BROWSER_SHARE_DATA_DIR
dir_array[${#dir_array[@]}]=$TANK_SHARE_DATA_DIR
dir_array[${#dir_array[@]}]=${TANK_SHARE_DATA_DIR}/gwq5210/root
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
dir_array[${#dir_array[@]}]=${DOCKER_SITE_KEY_DATA_DIR}/aliyunpan/sync_drive
dir_array[${#dir_array[@]}]=${DOCKER_SITE_BACKUP_DIR}/elasticsearch
dir_array[${#dir_array[@]}]=${DOCKER_SITE_BACKUP_DIR}/mysql
dir_array[${#dir_array[@]}]=${DOCKER_SITE_DATA_DIR}/jiacrontab
dir_array[${#dir_array[@]}]=${DOCKER_SITE_DATA_DIR}/scrapydweb
dir_array[${#dir_array[@]}]=${DOCKER_SITE_DATA_DIR}/qbittorrent/conf
dir_array[${#dir_array[@]}]=${DOCKER_SITE_DATA_DIR}/downloads

for dir in ${dir_array[@]};
do
  mkdir -p $dir
done

chmod 777 ${DOCKER_SITE_KEY_DATA_DIR}/elasticsearch/data

docker stack rm setup_keystore
# docker-compose -f setup-docker-compose.yml config | docker stack deploy -c - setup
./stack_deploy.sh setup_keystore setup-keystore-docker-compose.yml
