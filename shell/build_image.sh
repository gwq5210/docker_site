#!/bin/sh

cd `dirname "$0"`

image_name=`basename $PWD`

../build.sh $image_name