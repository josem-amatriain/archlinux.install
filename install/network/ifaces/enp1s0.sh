#!/bin/bash -x


IFACE="enp1s0"
MYIP="192.168.1.123"
GW="192.168.1.1"
MYMASK=24
BROADCAST="192.168.1.255"

TARGET="/etc/conf.d/network@$IFACE"


echo "

address=$MYIP
netmask=$MYMASK
broadcast=$BROADCAST
gateway=$GW


" > $TARGET

# Dont work in chroot
systemctl enable network@$IFACE.service
systemctl start network@$IFACE.service

