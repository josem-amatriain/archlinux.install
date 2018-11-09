#!/bin/bash -x

TARGET_DIR="/etc/systemd/system"
TARGET="network@.service"

MYDIR="/install"
source $MYDIR/etc/config.sh

cd $MYDIR

cp $MYDIR/network/resolv.conf /etc/resolv.conf

cp -p $MYDIR/network/$TARGET $TARGET_DIR/$TARGET

mkdir -p /etc/conf.d
cp -p $MYDIR/network/network@ /etc/conf.d/network@$IFACE

systemctl enable network@$IFACE.service
systemctl start network@$IFACE.service

