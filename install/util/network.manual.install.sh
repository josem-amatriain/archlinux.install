#!/bin/bash


IFACE="enp1s0"
IP="192.168.1.123"
NETMASK="24"
GW="192.168.1.1"
PING_TEST="1.1.1.1"
PING_URL="www.fsf.org"
DNS="9.9.9.9"


ip addr flush dev $IFACE
ip link set $IFACE down
sync
ip link set $IFACE up

ip addr add $IP/$NETMASK dev $IFACE
ip addr show $IFACE
ping -c2 $GW


# Routing to internet
ip route show 
ip route add default via $GW
ip route show 
ping -c3 $PING_TEST


# DNS internet resolution
#mv /etc/resolv.conf /etc/resolv.conf.0
echo -en "\nnameserver $DNS\n" >> /etc/resolv.conf

ping -c1 $PING_URL

