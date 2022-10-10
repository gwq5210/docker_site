#!/bin/sh

cd `dirname "$0"`

./stop.sh
docker stack rm setup
docker stack rm portainer
docker stack rm setup_certs
docker stack rm setup_keystore
./clear_secrets.sh
rm -rf ./home
