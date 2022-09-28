#!/bin/bash

export JAVA_BINARY=java

source env_from_file.sh MIRAI_VERIFY_KEY_FILE MIRAI_BOT_QQ_FILE MIRAI_BOT_QQ_PASSWORD_FILE

$JAVA_BINARY $MIRAI_JAVA_OPTS -jar mcl.jar $*