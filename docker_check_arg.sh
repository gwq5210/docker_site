#!/bin/sh

usage() {
  echo "USAGE: $0 image_name"
  find . -name "Dockerfile" | awk -F / '{print $2}' | xargs -I {} echo "  e.g.: $0 {}"
}

if [ $# != 1 ] ; then
  usage
  exit 1
fi

image_name=$1

if [ ! -n "$image_name" ]; then
  echo "image_name is empty"
  usage
  exit 1
fi

if [ ! -d "$image_name" ]; then
  echo "image_name[$image_name] does not exist"
  usage
  exit 1
fi

dockerfile=$image_name/Dockerfile

if [ ! -f "$dockerfile" ]; then
  echo "dockerfile[$dockerfile] does not exist"
  usage
  exit 1
fi