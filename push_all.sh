#!/bin/sh

cd `dirname "$0"`

image_name_list=`find . -name "Dockerfile" | awk -F / '{print $2}'`

for image_name in $image_name_list
do
  ./push.sh $image_name
done
