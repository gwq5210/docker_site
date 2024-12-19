#!/bin/sh

base_dir=`dirname "$0"`

password=$(${base_dir}/get_input.sh "password")
if [ x${password} == x ]; then
  echo "password can not be empty"
  exit 1
fi;

# 前32位
echo -n ${password} | sha256sum | cut -b -32