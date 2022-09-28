#!/bin/sh

cd `dirname "$0"`

docker-compose -f setup-docker-compose.yml run -it --rm setup_elasticsearch_keystore