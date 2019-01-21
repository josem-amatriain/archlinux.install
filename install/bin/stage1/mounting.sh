#!/bin/bash -x

source "$MYDIR/etc/root.partition"
source "$MYDIR/etc/boot.partition"

mount -t $ROOT_FS $ROOT_PARTITION /mnt
mkdir -p /mnt/boot
mount $BOOT_PARTITION /mnt/boot

INPUTFILE= "$MYDIR/etc/other.partition"
exec < $INPUTFILE
while read DEVICE FS MOUNTPOINT
do
	mkdir -p /mnt$MOUNTPOINT
	mount -t $FS $DEVICE /mnt$MOUNTPOINT
done
