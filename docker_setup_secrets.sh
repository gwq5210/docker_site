#!/bin/sh

cd `dirname "$0"`

./shell/docker_create_secret.sh -f -s gwq5210.com.crt -d certs/gwq5210.com/gwq5210.com.crt
./shell/docker_create_secret.sh -f -s gwq5210.com.key -d certs/gwq5210.com/gwq5210.com.key
./shell/docker_create_secret.sh -s elasticsearch_username.txt -d $(cat elasticsearch/elasticsearch_username.txt)
./shell/docker_create_secret.sh -s elasticsearch_bootstrap_password.txt -d $(cat elasticsearch/elasticsearch_bootstrap_password.txt)
./shell/docker_create_secret.sh -s elasticsearch_keystore_password.txt -d $(cat elasticsearch/elasticsearch_keystore_password.txt)
./shell/docker_create_secret.sh -s onebot_qq.txt -d $(cat napcat/noebot_qq.txt)
./shell/docker_create_secret.sh -s onebot__qq_password.txt -d $(cat napcat/noebot_qq_password.txt)
./shell/docker_create_secret.sh -s onebot_verify_key.txt -d $(cat napcat/noebot_verify_key.txt)
./shell/docker_create_secret.sh -s mysql_root_password.txt -d $(cat mysql/mysql_root_password.txt)
./shell/docker_create_secret.sh -s scrapyd_username.txt -d $(cat scrapyd/scrapyd_username.txt)
./shell/docker_create_secret.sh -s scrapyd_password.txt -d $(cat scrapyd/scrapyd_password.txt)
./shell/docker_create_secret.sh -s v2ray_uuid.txt -d $(cat v2ray/v2ray_uuid.txt)
./shell/docker_create_secret.sh -s portainer_token.txt -d "$(cat portainer_backup/portainer_token.txt)"
./shell/docker_create_secret.sh -s portainer_backup_password.txt -d $(cat portainer_backup/portainer_backup_password.txt)
./shell/docker_create_secret.sh -s aliyunpan_refresh_token.txt -d $(cat aliyunpan/aliyunpan_refresh_token.txt)
./shell/docker_create_secret.sh -s portainer_key.txt -d $(cat portainer/portainer_key.txt)