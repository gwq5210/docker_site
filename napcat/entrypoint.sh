#!/bin/bash

rm -rf "/tmp/.X1-lock"

: ${NAPCAT_GID:=0}
: ${NAPCAT_UID:=1000}

source env_from_file.sh NAPCAT_WEBUI_TOKEN ACCOUNT

cp /etc/napcat/webui.json /app/napcat/config
sed -i "s/\"token\":.*/\"token\": \"$NAPCAT_WEBUI_TOKEN\",/g" /app/napcat/config/webui.json

usermod -o -u ${NAPCAT_UID} napcat
groupmod -o -g ${NAPCAT_GID} napcat
usermod -g ${NAPCAT_GID} napcat
chown -R ${NAPCAT_UID}:${NAPCAT_GID} /app

gosu napcat Xvfb :1 -screen 0 1080x760x16 +extension GLX +render &
sleep 2
export FFMPEG_PATH=/usr/bin/ffmpeg
export DISPLAY=:1
cd /app/napcat
gosu napcat /opt/QQ/qq --no-sandbox -q $ACCOUNT