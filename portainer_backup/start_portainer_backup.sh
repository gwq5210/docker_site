#!/bin/sh

cd `dirname "$0"`

source env_from_file.sh PORTAINER_BACKUP_TOKEN PORTAINER_BACKUP_PASSWORD

/usr/local/bin/node /portainer-backup/src/index.js $@