#!/bin/bash -e

echo "Installing repos"
while read pkg; do
	yum install -y $pkg
done <<_EOT_
	epel-release
	yum-plugin-copr
_EOT_

echo "Enabling COPR repos"
while read repo; do
	yum copr enable -y "$repo"
done <<_EOT_
	macieks/openresolv
_EOT_

echo "Installing package groups"
while read group; do
	yum group install -y "$group"
done <<_EOT_
	Development Tools
_EOT_

echo "Installing packages"
while read pkg; do
	yum install -y $pkg
done <<_EOT_
	rsyslog
	sudo
	which
	openssh-server
	openssh-clients
	bind-utils
	sipcalc
	openvpn
	easy-rsa
	openresolv
_EOT_

