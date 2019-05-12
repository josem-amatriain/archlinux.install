#!/bin/bash -x


source alias.ip.config.sh

# example
# alias.ip.sh enp7s0:2 192.168.1.99 24 192.168.1.255 192.168.1.1



# interface=enp7s0:1
DEV=$1
# address=192.168.1.44
ADD=$2
# netmask=24
NET=$3
# broadcast=192.168.33.255
BRO=$4
# gateway=192.168.33.1
GW=$5


if [ -z "$DEV" ]; then 
	echo "Necesito un parámetro: interface tipo enp7s0:1 "
	DEV="enp7s0:1"
#	exit 0
else
	true
fi

NUM=$( echo $DEV  | cut -d':' -f2 )
IFACE="$( echo $DEV  | cut -d':' -f1 )"




ALIAS_PATH="/etc/conf.d/network_alias@$DEV"
ALIAS="interface=$DEV
address=$ADD
netmask=$NET
broadcast=$BRO
gateway=$GW
"


if [ -a "$ALIAS_PATH" ]; then
    true
else
    echo "$ALIAS" > $ALIAS_PATH
fi

systemctl enable network_alias@$DEV
systemctl start network_alias@$DEV
systemctl status network_alias@$DEV

