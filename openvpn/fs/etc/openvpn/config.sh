#!/bin/bash
SWD=$(dirname $0)

pushd $SWD

server/push_private_routes.sh

client/mkovpn.sh -in

if [ -f /mnt/sharedfs/client-out.conf ]; then
	cp /mnt/sharedfs/client-out.conf /etc/openvpn/client/
	systemctl enable openvpn-client@out
	systemctl start openvpn-client@out
fi

