#!/bin/sh

ZSH_PATH=`which zsh`
TARGET=$(echo "${ZSH_PATH}" | sed 's/\//\\\//g')
CMD="sed -i ""s/\/bin\/.*sh/${TARGET}/g"" /etc/passwd"
echo $CMD
$CMD