#!/bin/sh

cd `dirname "$0"`

GetInput() {
  msg=$1
  # stty -echo
  read -p "Please input $msg: " content
  echo $content
}

CreateSecretFile() {
  secret=$1
  if (docker secret ls | awk '{print $2}' | grep ${secret}) ; then
    echo "found docker secret $secret"
    return 0
  fi
  file_name=$(GetInput "$secret")
  docker secret create ${secret} $file_name
  return 0
}

CreateSecret() {
  secret=$1
  if (docker secret ls | awk '{print $2}' | grep ${secret}) ; then
    echo "found docker secret $secret"
    return 0
  fi
  content=$(GetInput "$secret")
  echo -n $content | docker secret create ${secret} -
  return 0
}

CreateSecretFile gwq5210.com.crt
CreateSecretFile gwq5210.com.key
CreateSecret elasticsearch_username.txt
CreateSecret elasticsearch_bootstrap_password.txt
CreateSecret elasticsearch_keystore_password.txt
if (docker secret ls | awk '{print $2}' | grep mirai_bot_qq.txt) ; then
  echo "found docker secret mirai_bot_qq.txt"
else
  echo "Set mirai_bot_qq.txt 2423087292"
  echo -n "2423087292" | docker secret create mirai_bot_qq.txt -
fi
CreateSecret mirai_bot_qq_password.txt
CreateSecret mirai_verify_key.txt
CreateSecret mysql_root_password.txt
if (docker secret ls | awk '{print $2}' | grep scrapyd_username.txt) ; then
  echo "found docker secret scrapyd_username.txt"
else
  echo "Set scrapyd_username.txt 2423087292"
  echo -n "gwq5210" | docker secret create scrapyd_username.txt -
fi
CreateSecret scrapyd_password.txt
CreateSecret v2ray_uuid.txt