#!/bin/sh

cd `dirname "$0"`

source env_from_file.sh V2RAY_UUID

if (cat /etc/v2ray/config.json | grep 'vmess') ; then
  echo "replace v2ray uuid"
  cat /etc/v2ray/config.json | tr '\n' ' ' | sed 's/[[:space:]]//g' | sed "s/id[^,]*/id\":\"$V2RAY_UUID\"/g" | /usr/bin/v2ray
else
  echo "not found vmess"
  /usr/bin/v2ray -config /etc/v2ray/config.json
fi