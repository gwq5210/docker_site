#!/bin/sh

cd `dirname "$0"`

image_name_list=`find . -name "Dockerfile" | awk -F / '{print $2}'`

for image_name in $image_name_list
do
  cat docker_push_template.yml | sed "s/DOCKER_APP_NAME/$image_name/g" > .github/workflows/$image_name.yml
done
