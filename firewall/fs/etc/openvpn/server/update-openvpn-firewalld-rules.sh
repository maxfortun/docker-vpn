#!/bin/bash -ex

firewall-cmd --permanent --add-service=openvpn
firewall-cmd --permanent --zone=trusted --add-interface=tun0

firewall-cmd --permanent --zone=trusted --add-masquerade

serverIp=$(ip route get 8.8.8.8 | awk '{print $7}'
vpnIp=$(grep -Po '(?<=^server )[^ ]*' /etc/openvpn/server/server.conf)
firewall-cmd --permanent --direct --passthrough ipv4 -t nat -A POSTROUTING -s  $vpnIp/24 -o $serverIp -j MASQUERADE
