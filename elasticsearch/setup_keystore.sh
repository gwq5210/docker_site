#!/bin/sh

ELASTIC_PASSWORD=`cat /run/secrets/elasticsearch_bootstrap_password.txt`
KEYSTORE_PASSWORD=`cat /run/secrets/elasticsearch_keystore_password.txt`

if [ ! -f /usr/share/elasticsearch/config/elasticsearch.keystore ]; then
  echo "Creating elasticsearch keystore";
  if [ x${KEYSTORE_PASSWORD} == x ]; then
    bin/elasticsearch-keystore create
  else
    COMMANDS="$(printf "%s\n%s" "$KEYSTORE_PASSWORD" "$KEYSTORE_PASSWORD")"
    echo "$COMMANDS" | bin/elasticsearch-keystore create -p
  fi
fi;

if ! (bin/elasticsearch-keystore has-passwd --silent) ; then
  echo "no keystore password"
  if (bin/elasticsearch-keystore list | grep '^bootstrap.password$') ; then
    echo "found bootstrap.password, first remove it"
    bin/elasticsearch-keystore remove bootstrap.password
  fi

  echo "$ELASTIC_PASSWORD" | bin/elasticsearch-keystore add bootstrap.password
else
  echo "has keystore password"
  if [ x${KEYSTORE_PASSWORD} == x ]; then
    echo "keystore password empty"
    exit 1;
  fi;

  if (echo "$KEYSTORE_PASSWORD" | bin/elasticsearch-keystore list | grep '^bootstrap.password$') ; then
    echo "found bootstrap.password, first remove it"
    echo "$KEYSTORE_PASSWORD" | bin/elasticsearch-keystore remove bootstrap.password
  fi

  COMMANDS="$(printf "%s\n%s" "$KEYSTORE_PASSWORD" "$ELASTIC_PASSWORD")"
  echo "$COMMANDS" | bin/elasticsearch-keystore add bootstrap.password
fi

echo "Setup elasticsearch keystore done"