#!/bin/bash
name=client$1
SWD=$(dirname $0)

pushd $SWD

OPENVPN_CA=$(cat ca.crt)
OPENVPN_CERT=$(cat ${name}.crt)
OPENVPN_KEY=$(cat ${name}.key)
OPENVPN_TLS_AUTH=$(cat ta.key)

cat client.ovpn.envsubst | envsubst > ${name}.ovpn
