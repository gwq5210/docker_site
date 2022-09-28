#!/bin/sh

docker-compose --compatibility up -d $@
./ps.sh
