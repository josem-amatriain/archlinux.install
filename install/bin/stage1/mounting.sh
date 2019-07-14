#!/bin/bash -x

MYDIR="/tmp/install"
source "$MYDIR/etc/root.partition"
source "$MYDIR/etc/boot.partition"

source $MYDIR/config/config.disks
for DISK in $DISKS; do
	partx -u $DISK
done

mount $ROOT_PARTITION /mnt

INPUTFILE="$MYDIR/etc/other.partition"
if [ -f $INPUTFILE ]; then 
 exec < $INPUTFILE
 while read DEVICE FS MOUNTPOINT
 do
	mkdir -p /mnt$MOUNTPOINT
	mount $DEVICE /mnt$MOUNTPOINT
 done
fi

mkdir -p /mnt/boot
mount $BOOT_PARTITION /mnt/boot
