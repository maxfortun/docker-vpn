#!/bin/bash -ex
SWD=$(dirname $0)

echo 'net.ipv4.ip_forward = 1' >> /etc/sysctl.conf
systemctl enable firewalld

