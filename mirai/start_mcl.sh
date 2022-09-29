#!/bin/bash

export JAVA_BINARY=java

source env_from_file.sh MIRAI_VERIFY_KEY MIRAI_BOT_QQ MIRAI_BOT_QQ_PASSWORD

cp /etc/mirai/Console/AutoLogin.yml /usr/share/mirai/config/Console/AutoLogin.yml
cp /etc/mirai/net.mamoe.mirai-api-http/setting.yml /usr/share/mirai/config/net.mamoe.mirai-api-http/setting.yml
sed -i "s/account:.*/account: $MIRAI_BOT_QQ/g" /usr/share/mirai/config/Console/AutoLogin.yml
sed -i "s/value:.*/value: $MIRAI_BOT_QQ_PASSWORD/g" /usr/share/mirai/config/Console/AutoLogin.yml
sed -i "s/verifyKey:.*/verifyKey: $MIRAI_VERIFY_KEY/g" /usr/share/mirai/config/net.mamoe.mirai-api-http/setting.yml

$JAVA_BINARY $MIRAI_JAVA_OPTS -jar mcl.jar $*