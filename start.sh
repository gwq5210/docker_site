#!/bin/bash

cd `dirname "$0"`

./compose_deploy.sh docker-compose.yml $*
