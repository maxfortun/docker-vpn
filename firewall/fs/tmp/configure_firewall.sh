#!/bin/bash -ex
SWD=$(dirname $0)

pushd $SWD

#  firewalld 0.6.3 has a bug, need to use a previous version 

yum install -y yum-plugin-versionlock

VERSION=0.5.3-5

rpms=()
pkgIds=()
for pkg in firewalld-filesystem firewalld python-firewall; do
	pkgId=$pkg-$VERSION.el7
	rpm=$pkgId.noarch.rpm
	curl -O http://vault.centos.org/7.6.1810/os/x86_64/Packages/$rpm
	rpms+=( $rpm )
	pkgIds+=( $pkg )
done
yum install -y ${rpms[*]}
yum versionlock ${pkgIds[*]}

echo 'net.ipv4.ip_forward = 1' >> /etc/sysctl.conf
systemctl enable firewalld

