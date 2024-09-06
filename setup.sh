#!/bin/sh

cd `dirname "$0"`

./compose_deploy.sh setup_certs setup-certs.yml

./setup_secrets.sh

DOCKER_SITE_KEY_DATA_DIR=$(cat .env | grep "DOCKER_SITE_KEY_DATA_DIR" | egrep -v "^#" | awk -F = '{print $2}')
DOCKER_SITE_DATA_DIR=$(cat .env | grep "DOCKER_SITE_DATA_DIR" | egrep -v "^#" | awk -F = '{print $2}')
DOCKER_SITE_CONF_DIR=$(cat .env | grep "DOCKER_SITE_CONF_DIR" | egrep -v "^#" | awk -F = '{print $2}')
DOCKER_SITE_LOGS_DIR=$(cat .env | grep "DOCKER_SITE_LOGS_DIR" | egrep -v "^#" | awk -F = '{print $2}')
DOCKER_SITE_BACKUP_DIR=$(cat .env | grep "DOCKER_SITE_BACKUP_DIR" | egrep -v "^#" | awk -F = '{print $2}')
es_config_dir=${DOCKER_SITE_KEY_DATA_DIR}/elasticsearch/config
kibana_config_dir=${DOCKER_SITE_KEY_DATA_DIR}/kibana/config
mkdir -p $es_config_dir $kibana_config_dir
chmod 777 $es_config_dir $kibana_config_dir

dir_array=()
dir_array[${#dir_array[@]}]=${DOCKER_SITE_LOGS_DIR}/nginx
dir_array[${#dir_array[@]}]=${DOCKER_SITE_LOGS_DIR}/mysql
dir_array[${#dir_array[@]}]=${DOCKER_SITE_KEY_DATA_DIR}/mysql
dir_array[${#dir_array[@]}]=${DOCKER_SITE_LOGS_DIR}/v2ray
dir_array[${#dir_array[@]}]=${DOCKER_SITE_LOGS_DIR}/scrapyd
dir_array[${#dir_array[@]}]=${DOCKER_SITE_DATA_DIR}/scrapyd
dir_array[${#dir_array[@]}]=${DOCKER_SITE_LOGS_DIR}/napcat
dir_array[${#dir_array[@]}]=${DOCKER_SITE_CONF_DIR}/napcat
dir_array[${#dir_array[@]}]=${DOCKER_SITE_KEY_DATA_DIR}/elasticsearch/data
dir_array[${#dir_array[@]}]=${DOCKER_SITE_KEY_DATA_DIR}/aliyunpan/sync_drive
dir_array[${#dir_array[@]}]=${DOCKER_SITE_BACKUP_DIR}/elasticsearch
dir_array[${#dir_array[@]}]=${DOCKER_SITE_BACKUP_DIR}/mysql
dir_array[${#dir_array[@]}]=${DOCKER_SITE_DATA_DIR}/scrapydweb
dir_array[${#dir_array[@]}]=${DOCKER_SITE_DATA_DIR}/downloads

for dir in ${dir_array[@]};
do
  mkdir -p $dir
done

chmod 777 ${DOCKER_SITE_KEY_DATA_DIR}/elasticsearch/data

./compose_deploy.sh setup-keystore.yml
