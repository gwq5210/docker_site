#!/bin/sh

cd `dirname "$0"`

docker-compose -f setup-docker-compose.yml --compatibility run --rm setup_elasticsearch_keystore