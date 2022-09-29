#!/bin/sh

ELASTIC_USERNAME=`cat /run/secrets/elasticsearch_username.txt`
ELASTIC_PASSWORD=`cat /run/secrets/elasticsearch_bootstrap_password.txt`

if [ ! -f /usr/share/kibana/config/kibana.keystore ]; then
  echo "Creating kibana keystore";
  bin/kibana-keystore create
fi;

bin/kibana-keystore remove elasticsearch.username
bin/kibana-keystore remove elasticsearch.password

echo $ELASTIC_USERNAME | bin/kibana-keystore add -x elasticsearch.username
echo $ELASTIC_PASSWORD | bin/kibana-keystore add -x elasticsearch.password

# chmod 640 /usr/share/elasticsearch/config/elasticsearch.keystore

echo "Setup kibana keystore done"