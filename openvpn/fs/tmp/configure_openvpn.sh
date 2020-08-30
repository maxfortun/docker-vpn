#!/bin/bash -ex
SWD=$(dirname $0)

while read pkg; do
    yum install -y $pkg
done <<_EOT_
	bind-utils
_EOT_


privateIp=$(ip a show eth0|grep -Po '(?<=inet )[^ /]*')
publicIp=$(dig +short myip.opendns.com @resolver1.opendns.com || dig -4 TXT +short o-o.myaddr.l.google.com @ns1.google.com | awk -F'"' '{ print $2}')

cp /usr/share/doc/openvpn-*/sample/sample-config-files/server.conf /etc/openvpn/server/

pushd /etc/openvpn/server/

openvpn --genkey --secret ta.key

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
_EOT_

# Comment undesired features
while read line; do
	sed -i 's/\('"$line"'\)/;\1/g' server.conf
done <<_EOT_
tls-auth ta.key
_EOT_

# Append custom features
cat >> server.conf <<_EOT_
script-security 2
learn-address /etc/openvpn/server/learn-address.sh
_EOT_

# need to push routes to 192/* from outside container
popd

systemctl enable openvpn@server
