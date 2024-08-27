#!/bin/bash

cd `dirname "$0"`

if [ ! -d "/run/secrets" ]; then
  echo "/run/secrets does not exist"
  exit 0
fi

secrets=$(ls /run/secrets)
for secret in $secrets
do
  echo "----- begin /run/secrets/$secret -----"
  echo $(cat /run/secrets/$secret)
  echo "----- end /run/secrets/$secret -----"
done