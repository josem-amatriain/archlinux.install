#!/bin/bash -x

MYDIR="/install"
source "$MYDIR/etc/root.partition"
source "$MYDIR/etc/boot.partition"

mount $ROOT_PARTITION /mnt
mkdir -p /mnt/boot
mount $BOOT_PARTITION /mnt/boot

INPUTFILE="$MYDIR/etc/other.partition"
exec < $INPUTFILE
while read DEVICE FS MOUNTPOINT
do
	mkdir -p /mnt$MOUNTPOINT
	mount $DEVICE /mnt$MOUNTPOINT
done
