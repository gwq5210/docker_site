#!/bin/sh

cd `dirname "$0"`

image_name=`basename $PWD`

../push.sh $image_name