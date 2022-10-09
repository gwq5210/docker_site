#!/bin/sh

cd `dirname "$0"`

docker stack services portainer
