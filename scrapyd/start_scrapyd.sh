#!/bin/bash

cd `dirname "$0"`

git clone https://github.com/gwq5210/spider.git && pip3 install -r spider/requirements.txt && rm -rf spider

source env_from_file.sh SCRAPYD_USERNAME SCRAPYD_PASSWORD

cp /etc/scrapyd/scrapyd.conf ~/.scrapyd.conf
sed -i "s/username.*=.*/username    = $SCRAPYD_USERNAME/g" ~/.scrapyd.conf
sed -i "s/password.*=.*/password    = $SCRAPYD_PASSWORD/g" ~/.scrapyd.conf

scrapyd --logfile=/var/log/scrapyd/scrapyd.log