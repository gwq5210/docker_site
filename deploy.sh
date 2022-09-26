#!/bin/sh

cd `dirname "$0"`

./docker_check_arg.sh $@

./build.sh $@ && ./push.sh $@