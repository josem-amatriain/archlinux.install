#!/bin/bash -x

MYDIR="/tmp/install"
cd $MYDIR
source etc/config.sh
source etc/bashrc

clear


gdisk -l $PARTICION
echo "You are about to delete yout disk partition $PARTICION"
read x


parted $PARTICION < disk/parted

gdisk -l $PARTICION

