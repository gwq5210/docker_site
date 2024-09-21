#!/bin/bash

cd `dirname "$0"`

requirements_file=$PIP_REQUIREMENTS_FILE
if [ ! -z "$requirements_file" ] && [ -f $requirements_file ]
then
  pip3 install -r $requirements_file
fi

source env_from_file.sh SCRAPYD_USERNAME SCRAPYD_PASSWORD

cp /etc/scrapyd/scrapyd.conf ~/.scrapyd.conf
sed -i "s/username.*=.*/username    = $SCRAPYD_USERNAME/g" ~/.scrapyd.conf
sed -i "s/password.*=.*/password    = $SCRAPYD_PASSWORD/g" ~/.scrapyd.conf

scrapyd --logfile=/var/log/scrapyd/scrapyd.log