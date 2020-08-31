#!/bin/bash
SWD=$(dirname $0)

pushd $SWD

server/push_private_routes.sh

client/mkovpn.sh
