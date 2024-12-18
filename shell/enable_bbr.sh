#!/bin/sh

sudo sh -c 'echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf'
sudo sh -c 'echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf'

sudo sysctl -p

sysctl net.ipv4.tcp_congestion_control