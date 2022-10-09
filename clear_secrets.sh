#!/bin/sh

cd `dirname "$0"`

ClearSecret() {
  secret=$1
  if (docker secret ls | awk '{print $2}' | grep ${secret}) ; then
    echo "found docker secret $secret, clear it"
    docker secret rm $secret
  else
    echo "not found docker secret $secret"
  fi
  return 0
}

ClearSecret gwq5210.com.crt
ClearSecret gwq5210.com.key
ClearSecret elasticsearch_username.txt
ClearSecret elasticsearch_bootstrap_password.txt
ClearSecret elasticsearch_keystore_password.txt
ClearSecret mirai_bot_qq.txt
ClearSecret mirai_bot_qq_password.txt
ClearSecret mirai_verify_key.txt
ClearSecret mysql_root_password.txt
ClearSecret scrapyd_username.txt
ClearSecret scrapyd_password.txt
ClearSecret v2ray_uuid.txt