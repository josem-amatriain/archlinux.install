#!/bin/bash -x


dev=$1
address=$2
net=$3
# No se usa
broadcast=$4
gw=$5




#ip addr add 192.168.2.101/24 dev eth0 label eth0:1
#ip addr add   $address/$net   dev $dev label $dev:$alias
# ip addr del 192.168.2.101/24 dev eth0:1
ip  addr del   $address/$net   dev $dev

exit 0
