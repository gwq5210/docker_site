#!/bin/sh

cd `dirname "$0"`

image_name_list=$(grep image *.yml | awk '{print $3}' | sort | uniq)

for image_name in $image_name_list
do
  docker pull $image_name
done