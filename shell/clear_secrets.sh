#!/bin/sh

usage() {
  echo "USAGE: $0 docker_secrets..."
}

if [ $# -lt 1 ] ; then
  usage
  exit 1
fi

secrets=$@

for secret in $secrets
do
  if (docker secret ls | awk '{print $2}' | egrep "^${secret}$") ; then
    echo "found docker secret $secret, remove it"
    docker secret rm $secret
  else
    echo "not found docker secret $secret"
  fi
done
