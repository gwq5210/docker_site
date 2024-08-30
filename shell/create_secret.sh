#!/bin/bash

usage() {
  echo "USAGE: $0 [OPTIONS]"
  echo "Description:"
  echo "-f: read secret from file"
  echo "-u: update if exist"
  echo "-d: default_value"
  echo "-s: secret file name"
  echo "-h: print help message"
  exit 0
}

if [ $# -lt 1 ] ; then
  usage
  exit 1
fi

base_dir=`dirname "$0"`
secret_dir="secrets"

mkdir -p $secret_dir

update="false"
from_file="false"
default_value=""
secret_file_name=""

while getopts 'hfud:s:' OPT; do
    case $OPT in
        f) from_file="true";;
        u) update="true";;
        d) default_value="$OPTARG";;
        s) secret_file_name="$OPTARG";;
        h) usage;;
        ?) usage;;
    esac
done

if [ x${secret_file_name} == x ]; then
  echo "secret file name is empty"
  usage
  exit 0
fi;

# echo "pwd: $PWD"
# echo "update: $update"
# echo "from_file: $from_file"
# echo "secret_file_name: $secret_file_name"
# echo "default_value: $default_value"

secret_full_file_name=${secret_dir}/${secret_file_name}

# echo "secret_full_file_name: ${secret_full_file_name}"

if [ -f ${secret_full_file_name} ] ; then
  if [ "${update}" == "true" ]; then
    ./clear_secrets.sh $secret_file_name
  else
    echo "found secret $secret_file_name, skip it"
    exit 0
  fi
else
  echo "not found secret $secret_file_name, create new secret"
fi

content=$($base_dir/get_input.sh "$secret_file_name" "$default_value")
if [ "${from_file}" == "true" ]; then
  if [ -f ${content} ] ; then
    cat ${content} > $secret_full_file_name
  else
    echo "not found $content, create secret failed"
    exit 1
  fi
else
  echo -n $content > $secret_full_file_name
fi
echo "create ${secret_file_name} success!"