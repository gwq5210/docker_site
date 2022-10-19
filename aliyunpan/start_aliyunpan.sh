#!/bin/sh

cd `dirname "$0"`

source env_from_file.sh ALIYUNPAN_REFRESH_TOKEN

./app.sh $@