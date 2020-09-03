#!/bin/bash -ex
name=client$1

pushd /etc/openvpn/easy-rsa/3/

./easyrsa --batch gen-req $name nopass
./easyrsa --batch sign-req client $name

cp pki/issued/${name}.crt /etc/openvpn/client/
cp pki/private/${name}.key /etc/openvpn/client/

popd
