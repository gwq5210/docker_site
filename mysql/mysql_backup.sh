#!/bin/bash

# 定义工作路径
BASE_DIR=/usr/share/mysql

# 备份文件存放地址(根据实际情况填写)
backup_location=$BASE_DIR/backup

echo "$(date "+%Y-%m-%d %H:%M:%S") backup_location: $backup_location"

# 判断路径是否存在
if [ ! -d "$backup_location" ]; then
    mkdir -p $backup_location
fi

# 设置mysql的登录用户名和密码(根据实际情况填写)
mysql_user="root"
mysql_host="localhost"
mysql_port="3306"
mysql_charset="utf8mb4"

# 增加日志路径 #时间格式DATE=`date '+%Y%m%d-%H%M'`
LOGFILE=$backup_location/mysql-backup.log
echo "$(date "+%Y-%m-%d %H:%M:%S") logfile: $LOGFILE"

# 是否删除过期数据
expire_backup_delete="ON"
expire_days=7
backup_time=`date +%Y%m%d%H%M%S`
backup_dir=$backup_location
welcome_msg="Welcome to use MySQL backup tools!"
mysql_backup_file=mysql_backup_${backup_time}.sql

time=$(date "+%Y-%m-%d %H:%M:%S")
echo "${time} START BACKUP"
echo "${time} START BACKUP ">> $LOGFILE

backup_cmd="mysqldump -h$mysql_host -P$mysql_port -u$mysql_user --all-databases"
echo "${time} $backup_cmd > ${backup_dir}/${mysql_backup_file}"
echo "${time} $backup_cmd > ${backup_dir}/${mysql_backup_file}" >> $LOGFILE

$backup_cmd -p$(cat /run/secrets/mysql_root_password.txt) > ${backup_dir}/${mysql_backup_file}

time=$(date "+%Y-%m-%d %H:%M:%S")
if [ $? -ne 0 ]; then
  rm -rf ${backup_dir}/${mysql_backup_file}
  echo '${time} FINISH ERROR'
  echo '${time} FINISH ERROR' >> $LOGFILE
  exit
  EOF
fi
echo "${time} FINISH BACKUP"
echo "${time} FINISH BACKUP" >> $LOGFILE

# 删除过期数据
if [ "$expire_backup_delete" == "ON" -a "$backup_location" != "" ];then
  #删除7天以上的备份
  find $backup_location/ -type f -mtime +$expire_days | xargs rm -rf
  echo ${time}' Expired backup data delete complete!'
  echo ${time}' Expired backup data delete complete!' >> $LOGFILE
fi
