#!/bin/bash

SWD=$(dirname $0)

action=$1
address=$2
type=$3

if [ -z "$address" ]; then
	exit
fi

LOG=/var/log/openvpn/learn-address.log

echo $(date '+%Y-%m-%d %H:%M:%S') $* >> $LOG
env | sort | xargs -L 1 echo $(date '+%Y-%m-%d %H:%M:%S') $address >> $LOG
 
case $action in
	add|update)
		echo "$(date '+%Y-%m-%d %H:%M:%S') $address ip route del $address/32" >> $LOG
				$SWD/unpriv-ip route del $address/32 >> $LOG 2>&1 
		echo "$(date '+%Y-%m-%d %H:%M:%S') $address ip route add $address/32 dev $dev" >> $LOG
				$SWD/unpriv-ip route add $address/32 dev $dev >> $LOG 2>&1
	;;
	delete)
		echo "$(date '+%Y-%m-%d %H:%M:%S') $address ip route del $address/32" >> $LOG
				$SWD/unpriv-ip route del $address/32 >> $LOG 2>&1 
	;;
	*)
	;;
esac
 
exit 0;
