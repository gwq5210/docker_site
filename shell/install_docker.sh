#!/bin/sh

PKG="sudo apt"

curl -fsSL https://get.docker.com -o get-docker.sh && \
sudo sh get-docker.sh && \
sudo $PKG install docker-compose