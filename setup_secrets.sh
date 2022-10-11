#!/bin/sh

cd `dirname "$0"`

./shell/create_secret.sh -f -s gwq5210.com.crt -d certs/gwq5210.com/gwq5210.com.crt
./shell/create_secret.sh -f -s gwq5210.com.key -d certs/gwq5210.com/gwq5210.com.key
./shell/create_secret.sh -s elasticsearch_username.txt -d $(cat elasticsearch/elasticsearch_username.txt)
./shell/create_secret.sh -s elasticsearch_bootstrap_password.txt -d $(cat elasticsearch/elasticsearch_bootstrap_password.txt)
./shell/create_secret.sh -s elasticsearch_keystore_password.txt -d $(cat elasticsearch/elasticsearch_keystore_password.txt)
./shell/create_secret.sh -s mirai_bot_qq.txt -d $(cat mirai/mirai_bot_qq.txt)
./shell/create_secret.sh -s mirai_bot_qq_password.txt -d $(cat mirai/mirai_bot_qq_password.txt)
./shell/create_secret.sh -s mirai_verify_key.txt -d $(cat mirai/mirai_verify_key.txt)
./shell/create_secret.sh -s mysql_root_password.txt -d $(cat mysql/mysql_root_password.txt)
./shell/create_secret.sh -s scrapyd_username.txt -d $(cat scrapyd/scrapyd_username.txt)
./shell/create_secret.sh -s scrapyd_password.txt -d $(cat scrapyd/scrapyd_password.txt)
./shell/create_secret.sh -s v2ray_uuid.txt -d $(cat v2ray/v2ray_uuid.txt)