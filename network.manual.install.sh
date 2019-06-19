#!/bin/bash

clear

######################################################################
#
# You must change default values
# 
# Gateway/Router IP
GW="192.168.1.1"
# Interface/Network device
IFACE=$( dmesg | grep '[^ ]*: Link is Down' -o | cut -f1 -d':' )
# IP/NETWORK MASK
IP="192.168.1.40"
NETMASK="24"
# URL for testing purpouses
PING_URL="www.archlinux.org"
# DNS resolver
DNS1="9.9.9.9"
DNS2="8.8.8.8"
# Address for testing purpouses
PING_TEST=$DNS1
# Keyboard layout
KEYS="es"
#######################################################################
echo "To setup the network device correctly you need:
device name:"
dmesg | grep '[^ ]*: Link is Down' -o
ip link show | grep -v 'lo:' | grep -v loopback

echo "Lets supose the network device is $IFACE, tha gateway is $GW
the address is $IP/$NETMASK DNS=$DNS1 $DNS2
Press enter to continue or control+c to cancel and change default values."
read x
######################################################################

loadkeys $KEYS

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


#################################################################
echo "Now you can run the init.sh script"
read x 
ip addr show | grep inet | grep -v inet6 | grep -v 127

wget https://raw.githubusercontent.com/josem-amatriain/archlinux.install/master/init.sh -O /tmp/init.sh

chmod a+x /tmp/init.sh

/tmp/init.sh 
