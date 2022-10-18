#!/bin/bash

cd `dirname "$0"`

image_name_list=$(grep image *.yml | sed 's/#.*//g' | awk '{print $3}' | sort | uniq)

for image_name in $image_name_list
do
  if [ -z "$image_name" ] ; then
    continue
  fi
  echo docker pull $image_name
  docker pull $image_name
done