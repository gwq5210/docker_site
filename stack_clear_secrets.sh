#!/bin/sh

cd `dirname "$0"`

./shell/stack_clear_secrets.sh gwq5210.com.crt
./shell/stack_clear_secrets.sh gwq5210.com.key
./shell/stack_clear_secrets.sh elasticsearch_username.txt
./shell/stack_clear_secrets.sh elasticsearch_bootstrap_password.txt
./shell/stack_clear_secrets.sh elasticsearch_keystore_password.txt
./shell/stack_clear_secrets.sh mirai_bot_qq.txt
./shell/stack_clear_secrets.sh mirai_bot_qq_password.txt
./shell/stack_clear_secrets.sh mirai_verify_key.txt
./shell/stack_clear_secrets.sh mysql_root_password.txt
./shell/stack_clear_secrets.sh scrapyd_username.txt
./shell/stack_clear_secrets.sh scrapyd_password.txt
./shell/stack_clear_secrets.sh v2ray_uuid.txt
./shell/stack_clear_secrets.sh portainer_token.txt
./shell/stack_clear_secrets.sh portainer_backup_password.txt
./shell/stack_clear_secrets.sh aliyunpan_refresh_token.txt
./shell/stack_clear_secrets.sh portainer_key.txt