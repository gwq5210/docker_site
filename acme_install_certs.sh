#!/bin/bash

cd `dirname "$0"`

acme_home=$HOME/.acme.sh
acme=$acme_home/acme.sh
certs_path=$acme_home/gwq5210.com/ssl
crt_file=$certs_path/gwq5210.com.crt
key_file=$certs_path/gwq5210.com.key

mkdir -p $certs_path

$acme --install-cert -d gwq5210.com -d *.gwq5210.com \
  --key-file      $key_file  \
  --fullchain-file $crt_file \
  --reloadcmd     "$PWD/update_certs.sh"
