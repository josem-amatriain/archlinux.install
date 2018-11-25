#!/bin/bash -x

clear

cd /install
source etc/config.sh
source etc/$IFACE.sh

ip addr add $IP/24 dev $IFACE
cp $MYDIR/network/resolv.conf /etc/resolv.conf
ip link set $IFACE up 

ping -c8 $GW

ip route add default via $GW

ping -c3 8.8.8.8

ip route show 


ip addr show $IFACE
ping -c2 $GW
ping -c8 archlinux.org

