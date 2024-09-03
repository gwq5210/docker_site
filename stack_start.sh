#!/bin/bash

cd `dirname "$0"`

./stack_deploy.sh docker_site docker-compose-stack.yml
