#!/bin/sh

usage() {
  echo "USAGE: $0 docker_secrets..."
}

if [ $# -lt 1 ] ; then
  usage
  exit 1
fi

base_dir=`dirname "$0"`
secret_dir="secrets"
secret_backup_dir="secrets_backup"
time_str=$(date "+%Y%m%d%H%M%S")

secrets=$@

for secret_file_name in $secrets
do
  secret_full_file_name=${secret_dir}/${secret_file_name}
  secret_full_backup_file_name=${secret_backup_dir}/${time_str}_${secret_file_name}
  # echo "secret_file_name: ${secret_file_name}"
  # echo "secret_full_file_name: ${secret_full_file_name}"
  # echo "secret_full_backup_file_name: ${secret_full_backup_file_name}"
  if [ -f ${secret_full_file_name} ] ; then
    echo "backup ${secret_full_file_name} to ${secret_full_backup_file_name}, and remove ${secret_full_file_name}"
    mkdir -p $secret_backup_dir && cp ${secret_full_file_name} ${secret_full_backup_file_name} && rm ${secret_full_file_name}
  else
    echo "not found $secret_full_file_name, skip it"
  fi
done
