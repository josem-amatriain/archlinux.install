#!/bin/bash

source /install/etc/config.stage2.sh
#source $MYDIR/etc/config.net.sh
cd $MYDIR

TARGET="network@.service"

echo -en "\n$HOSTNAME\n" > /etc/hostname
echo -en "\n127.0.0.1  localhost.localdomain localhost\n$MYIP $HOSTNAME\n" >> /etc/hosts


# Not working in chroot
#mv /etc/resolv.conf /etc/resolv.conf.0
#cp $MYDIR/etc/network/resolv.conf /etc/resolv.conf

cp -p $MYDIR/etc/network/$TARGET "/etc/systemd/system/$TARGET"

mkdir -p /etc/conf.d

for IFACE in $MYDIR/etc/network/ifaces/*.sh
do
    source $IFACE
done




