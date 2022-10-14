#!/bin/bash

docker exec $(docker ps | grep mysql | awk '{print $1}') mysql_backup.sh