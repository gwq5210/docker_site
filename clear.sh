#!/bin/sh

cd `dirname "$0"`

docker stack rm setup
./stop.sh
rm -rf ./home
