#!/bin/bash -ex
SWD=$(dirname $0)

if [ ! -d /var/log/openvpn ]; then
	mkdir -p /var/log/openvpn
	chown nobody:nobody /var/log/openvpn
fi

cp /usr/share/doc/openvpn-*/sample/sample-config-files/server.conf /etc/openvpn/server/

pushd /etc/openvpn/server/

openvpn --genkey --secret ta.key
cp ta.key ../client/

# Uncomment desired features
while read line; do
	sed -i 's/;\('"$line"'\)/\1/g' server.conf
done <<_EOT_
topology subnet
client-to-client
duplicate-cn
comp-lzo
user nobody
group nobody
push "redirect-gateway def1 bypass-dhcp"
_EOT_

# Comment undesired features
while read line; do
	sed -i 's/\('"$line"'\)/;\1/g' server.conf
done <<_EOT_
ifconfig-pool-persist ipp.txt
_EOT_

# Append custom features
cat >> server.conf <<_EOT_

script-security 2
learn-address /etc/openvpn/server/learn-address.sh
log /var/log/openvpn/server.log

_EOT_

mv dh.pem dh2048.pem

# need to push routes to 192/* from outside container
popd

systemctl enable openvpn-server@server
systemctl enable openvpn-local-conf
