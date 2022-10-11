#!/bin/bash

usage() {
  echo "USAGE: $0 tip_msg [default_value]"
}

if [ $# -lt 1 ] ; then
  usage
  exit 1
fi

msg=$1
default_value=$2

# stty -echo

content=$default_value
if [ x${default_value} == x ]; then
  read -p "Please input $msg: " content
else
  read -p "Please input $msg(empty for $default_value): " content
fi;
if [ x${content} == x ]; then
  content=$default_value
fi;
echo $content