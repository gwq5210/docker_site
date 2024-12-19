#!/bin/bash

requirements_file=$PIP_REQUIREMENTS_FILE
if [ ! -z "$requirements_file" ] && [ -f $requirements_file ]
then
  pip3 install -r $requirements_file
fi

source env_from_file.sh SCRAPYD_USERNAME SCRAPYD_PASSWORD MYSQL_ROOT_PASSWORD

cp /etc/spider_admin_pro/config.yml config.yml
sed -i "s/USERNAME: .*/USERNAME: \"$SCRAPYD_USERNAME\"/g" config.yml
sed -i "s/PASSWORD: .*/PASSWORD: \"$SCRAPYD_PASSWORD\"/g" config.yml
sed -i "s/\${mysql_root_password}/$MYSQL_ROOT_PASSWORD/g" config.yml

gunicorn --bind '0.0.0.0:8000' 'spider_admin_pro:app'