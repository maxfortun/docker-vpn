#!/bin/bash -ex

# --zone=trusted ? some ? all ?

firewall-cmd --set-default-zone=trusted
firewall-cmd --permanent --add-service=openvpn
firewall-cmd --permanent --add-interface=tun0
firewall-cmd --permanent --add-masquerade
firewall-cmd --permanent --add-port=1194/udp


serverIp=$(ip route get 8.8.8.8 | awk '{print $7}')
vpnIp=$(grep -Po '(?<=^server )[^ ]*' /etc/openvpn/server/server.conf)
firewall-cmd --permanent --direct --passthrough ipv4 -t nat -A POSTROUTING -s  $vpnIp/24 -o $serverIp -j MASQUERADE

firewall-cmd --reload
