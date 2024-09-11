#!/bin/sh

cd `dirname "$0"`

nginx_id=$(docker ps | grep gwq5210_nginx | awk '{print $1}')
echo docker exec -it $nginx_id nginx -s reload
docker exec -it $nginx_id nginx -s reload