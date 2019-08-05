#!/bin/bash -x

# LOAD parameters
source /tmp/install/config/config.sh

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
if [ $? -eq 0 ]; then true; 
	cat /etc/resolv.conf > /etc/resolv2.conf
	echo -en "nameserver $DNS1\n
nameserver $DNS2\n
" > /etc/resolv.conf
	cat /etc/resolv2.conf >> /etc/resolv.conf
else
	
	echo -en "nameserver $DNS1\n
nameserver $DNS2\n
" >> /etc/resolv.conf
	cat $MYDIR/etc/network/resolv.conf >> /etc/resolv.conf
	ping -c1 $PING_URL
fi

if [ -z "$DOMAIN" ]; then true
else
	echo -en "\ndomain $DOMAIN\n" >> /etc/resolv.conf
fi
