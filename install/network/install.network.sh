#!/bin/bash -x





MYDIR="/install"
source $MYDIR/etc/config.sh
source $MYDIR/etc/config.net.sh

cd $MYDIR

TARGET="network@.service"

echo -en "\n$HOSTNAME\n" > /etc/hostname
echo -en "\n127.0.0.1  localhost.localdomain localhost\n$MYIP $HOSTNAME\n" >> /etc/hosts


cp $MYDIR/network/resolv.conf /etc/resolv.conf

cp -p $MYDIR/network/$TARGET "/etc/systemd/system/$TARGET"

mkdir -p /etc/conf.d

source $MYDIR/network/ifaces/*.sh

