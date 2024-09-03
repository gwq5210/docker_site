#!/bin/bash

cd `dirname "$0"`

usage() {
  echo "USAGE: $0 [OPTIONS]"
  echo "Description:"
  echo "-f: read secret from file"
  echo "-u: update if exist"
  echo "-d: default_value"
  echo "-s: docker secret"
  echo "-h: print help message"
  exit 0
}

if [ $# -lt 1 ] ; then
  usage
  exit 1
fi

update="false"
from_file="false"
default_value=""
secret=""

while getopts 'hfud:s:' OPT; do
    case $OPT in
        f) from_file="true";;
        u) update="true";;
        d) default_value="$OPTARG";;
        s) secret="$OPTARG";;
        h) usage;;
        ?) usage;;
    esac
done

# echo "update: $update"
# echo "from_file: $from_file"
# echo "secret: $secret"
# echo "default_value: $default_value"

if [ x${secret} == x ]; then
  echo "secret is empty"
  usage
  exit 0
fi;

found_secret=$(docker secret ls | awk '{print $2}' | egrep "^${secret}$")

if [ x"$found_secret" == x"$secret" ] ; then
  if [ "${update}" == "true" ]; then
    ./clear_secrets.sh $secret
  else
    echo "found docker secret $secret, skip it"
    exit 0
  fi
else
  echo "not found docker secret $secret, create new secret"
fi

content=$(./get_input.sh "$secret" "$default_value")
if [ "${from_file}" == "true" ]; then
  docker secret create ${secret} ${content}
else
  echo -n $content | docker secret create ${secret} -
fi