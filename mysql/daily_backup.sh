#!/bin/bash

cd `dirname "$0"`

PROC_NAME=`basename $0`

havefound=`crontab -l | grep "mysql_backup.sh"`
if [ -n "$havefound" ];then
  echo "mysql_backup crontab exists"
  exit 0
fi

backfile="/tmp/${PROC_NAME}_crontab.tmp"
if [ -f $backfile ];then
  echo "$backfile have exist, please remove it."
  exit 1
fi

backup_cmd="$PWD/docker_mysql_backup.sh > /dev/null"

crontabcmd="0 2 * * * $backup_cmd"
crontab -l > $backfile
printf "\n$crontabcmd\n">>$backfile
crontab $backfile

rm $backfile

printf "crontab have install:\n$crontabcmd\n"
