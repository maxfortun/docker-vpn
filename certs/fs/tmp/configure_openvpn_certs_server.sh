#!/bin/bash -ex

cp -r /usr/share/easy-rsa /etc/openvpn/
pushd /etc/openvpn/easy-rsa/3/

./easyrsa --batch init-pki
./easyrsa --batch build-ca nopass

./easyrsa --batch gen-req server nopass
./easyrsa --batch sign-req server server

./easyrsa --batch gen-dh

./easyrsa --batch gen-crl

cp pki/ca.crt /etc/openvpn/server/
cp pki/ca.crt /etc/openvpn/client/

cp pki/issued/server.crt /etc/openvpn/server/
cp pki/private/server.key /etc/openvpn/server/

cp pki/dh.pem /etc/openvpn/server/
cp pki/crl.pem /etc/openvpn/server/

popd
