#!/bin/bash

# LOAD parameters
source /tmp/install/etc/config.stage1.sh
cd $MYDIR
source etc/network/iface.sh

# LOCAL IP
ping -c1 $GW
if [ $? -eq 0 ]; then true; else 
    ip addr add $IP/$NETMASK dev $IFACE
    ip link set $IFACE up 
    ip addr show $IFACE
    ping -c2 $GW
fi

# Routing
ping -c1 $PING_TEST
if [ $? -eq 0 ]; then true; else 
    ip route show 
    ip route add default via $GW
    ip route show 

    ping -c3 $PING_TEST
fi

# DNS resolution
ping -c1 $PING_URL
if [ $? -eq 0 ]; then true; else 
    mv /etc/resolv.conf /etc/resolv.conf.0
    cp etc/network/resolv.conf /etc/resolv.conf
    ping -c1 $PING_URL
fi

