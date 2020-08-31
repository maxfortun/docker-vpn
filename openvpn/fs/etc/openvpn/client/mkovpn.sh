#!/bin/bash
name=client$1
SWD=$(dirname $0)

pushd $SWD

export OPENVPN_CA=$(cat ca.crt)
export OPENVPN_CERT=$(cat ${name}.crt)
export OPENVPN_KEY=$(cat ${name}.key)
export OPENVPN_TLS_AUTH=$(cat ta.key)

cat client.ovpn.envsubst | envsubst > ${name}.ovpn
