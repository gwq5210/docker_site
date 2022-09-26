#!/bin/sh

cd `dirname "$0"`

./docker_check_arg.sh $@

if [ $? -eq 0 ]; then
  image_name=$1
  docker push gwq5210/$image_name:latest
fi