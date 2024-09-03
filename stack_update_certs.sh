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

./stack_stop.sh
./stack_portainer_stop.sh

sleep 60

echo "" | ./shell/stack_create_secret.sh -f -u -s gwq5210.com.crt -d $crt_file
echo "" | ./shell/stack_create_secret.sh -f -u -s gwq5210.com.key -d $key_file

./stack_start.sh
./stack_portainer_start.sh
