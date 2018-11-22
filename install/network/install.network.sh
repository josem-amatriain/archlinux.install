#!/bin/bash -x


TARGET="network@.service"

MYDIR="/install"
source $MYDIR/etc/config.sh

cd $MYDIR

cp $MYDIR/network/resolv.conf /etc/resolv.conf

cp -p $MYDIR/network/$TARGET "/etc/systemd/system/$TARGET"

mkdir -p /etc/conf.d

source $MYDIR/etc/ifaces/*.sh

