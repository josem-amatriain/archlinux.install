#!/bin/bash -x


dev=$1
address=$2
net=$3
# No se usa
broadcast=$4
gw==$5

alias=$( echo $dev  | cut -d':' -f2 )
iface=$( echo $dev  | cut -d':' -f1 )

#ip addr add 192.168.2.101/24 dev eth0 label eth0:1
ip addr add   $address/$net   dev $iface label $dev
#ip addr del 192.168.2.101/24 dev eth0:1

exit 0
