#!/bin/bash

cd `dirname "$0"`

usage() {
  echo "USAGE: $0 [OPTIONS]"
  echo "Description:"
  echo "-n: docker container name or id"
  echo "-h: print help message"
  exit 0
}

if [ $# -lt 0 ] ; then
  usage
  exit 1
fi

docker_container_name="*"

while getopts 'hn:' OPT; do
    case $OPT in
        n) docker_container_name="$OPTARG";;
        h) usage;;
        ?) usage;;
    esac
done

docker_container_id_list=()
if [ x${docker_container_name} == x ]; then
  docker_container_id_list=$(docker ps | grep -v 'CONTAINER ID' | awk '{print $1}')
else
  docker_container_id_list=$(docker ps | grep -v 'CONTAINER ID' | grep ${docker_container_name} | awk '{print $1}')
fi;

echo docker_container_name: ${docker_container_name}
echo docker_container_id_list: ${docker_container_id_list}

for docker_container_id in $docker_container_id_list
do
  echo docker_container_id: ${docker_container_id}
  docker exec -i ${docker_container_id} sh < ./show_docker_secrets.sh
done
