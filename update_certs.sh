#!/bin/bash

cd `dirname "$0"`

certs_path=$HOME/.acme.sh/gwq5210.com/ssl
crt_file=$certs_path/gwq5210.com.crt
key_file=$certs_path/gwq5210.com.key

if [ ! -f $crt_file ]; then
  echo "crt_file $crt_file not found"
  exit 1
fi

if [ ! -f $key_file ]; then
  echo "key_file $key_file not found"
  exit 1
fi

./stop.sh
./portainer_stop.sh

sleep 60

echo "" | ./shell/create_secret.sh -f -u -s gwq5210.com.crt -d $crt_file
echo "" | ./shell/create_secret.sh -f -u -s gwq5210.com.key -d $key_file

./start.sh
./portainer_start.sh
