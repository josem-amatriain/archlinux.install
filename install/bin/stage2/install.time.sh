#!/bin/bash 

source /install/etc/config.stage2.sh
cd $MYDIR


rm -f /etc/localtime
ln -s /usr/share/zoneinfo/$ZONEINFO /etc/localtime
hwclock --systohc --utc
