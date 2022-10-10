#!/bin/sh

cd `dirname "$0"`

GetInput() {
  msg=$1
  default_value=$2
  
  # stty -echo
  if [ x${default_value} == x ]; then
    read -p "Please input $msg: " content
  else
    read -p "Please input $msg(empty for $default_value): " content
  fi;
  if [ x${content} == x ]; then
    content=$default_value
  fi;
  echo $content
}

CreateSecretFile() {
  secret=$1
  default_value=$2
  if (docker secret ls | awk '{print $2}' | grep ${secret}) ; then
    echo "found docker secret $secret"
    return 0
  fi
  file_name=$(GetInput "$secret" "$default_value")
  docker secret create ${secret} $file_name
  return 0
}

CreateSecret() {
  secret=$1
  default_value=$2
  if (docker secret ls | awk '{print $2}' | grep ${secret}) ; then
    echo "found docker secret $secret"
    return 0
  fi
  content=$(GetInput "$secret" "$default_value")
  echo -n $content | docker secret create ${secret} -
  return 0
}

CreateSecretFile gwq5210.com.crt certs/gwq5210.com/gwq5210.com.crt
CreateSecretFile gwq5210.com.key certs/gwq5210.com/gwq5210.com.key
CreateSecret elasticsearch_username.txt $(cat elasticsearch/elasticsearch_username.txt)
CreateSecret elasticsearch_bootstrap_password.txt $(cat elasticsearch/elasticsearch_bootstrap_password.txt)
CreateSecret elasticsearch_keystore_password.txt $(cat elasticsearch/elasticsearch_keystore_password.txt)
CreateSecret mirai_bot_qq.txt $(cat mirai/mirai_bot_qq.txt)
CreateSecret mirai_bot_qq_password.txt $(cat mirai/mirai_bot_qq_password.txt)
CreateSecret mirai_verify_key.txt $(cat mirai/mirai_verify_key.txt)
CreateSecret mysql_root_password.txt $(cat mysql/mysql_root_password.txt)
CreateSecret scrapyd_username.txt $(cat scrapyd/scrapyd_username.txt)
CreateSecret scrapyd_password.txt $(cat scrapyd/scrapyd_password.txt)
CreateSecret v2ray_uuid.txt $(cat v2ray/v2ray_uuid.txt)