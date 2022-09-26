#!/bin/sh

cd `dirname "$0"`

cd ../

image_name_list=`find . -name "Dockerfile" | awk -F / '{print $2}'`

for image_name in $image_name_list
do
  cd $image_name
  ln -sf ../shell/build_image.sh build.sh
  ln -sf ../shell/push_image.sh push.sh
  ln -sf ../shell/deploy_image.sh deploy.sh
  cd ..
done