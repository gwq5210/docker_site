#!/bin/sh

if [ ! -f config/certs/ca.zip ]; then
  mkdir -p config/certs
  echo "Creating CA";
  ./bin/elasticsearch-certutil ca --silent --pem -out config/certs/ca.zip && unzip config/certs/ca.zip -d config/certs
  if [ $? -ne 0 ]; then
    exit 1
  fi
else
  echo "ca.zip already exists"
fi;
if [ ! -f config/certs/certs.zip ]; then
  echo "Creating certs";
  ./bin/elasticsearch-certutil cert --silent --pem -out config/certs/certs.zip --in config/certs/instances.yml --ca-cert config/certs/ca/ca.crt --ca-key config/certs/ca/ca.key && unzip config/certs/certs.zip -d config/certs;
  if [ $? -ne 0 ]; then
    exit 1
  fi
else
  echo "certs.zip already exists"
fi;
echo "Setting file permissions"
chown -R elasticsearch:root config/certs;
cd config/certs
find . -type d -exec chmod 750 \{\} \;;
find . -type f -exec chmod 640 \{\} \;;
echo "Setup certs done"