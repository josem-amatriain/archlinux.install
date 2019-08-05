#!/bin/bash -x

# LOAD parameters
source /tmp/install/config/config.sh

source "$MYDIR/etc/root.partition"
source "$MYDIR/etc/boot.partition"
source $MYDIR/config/config.disks

for DISK in $DISKS; do
	partx -u $DISK
done

mount $ROOT_PARTITION /mnt
if [ $? -eq 0 ]; then true
else
	echo "Error mounting root partition $ROOT_PARTITION /mnt"
	exit 33
fi

INPUTFILE="$MYDIR/etc/other.partition"
if [ -f $INPUTFILE ]; then 
 exec < $INPUTFILE
 while read DEVICE FS MOUNTPOINT
 do
	mkdir -p /mnt$MOUNTPOINT
	mount $DEVICE /mnt$MOUNTPOINT
	if [ $? -eq 0 ]; then true
	else
		echo "Error mounting partition $DEVICE /mnt$MOUNTPOINT"
		exit 35
	fi

 done
fi

mkdir -p /mnt/boot
mount $BOOT_PARTITION /mnt/boot
if [ $? -eq 0 ]; then true
else
	echo "Error mounting boot partition $BOOT_PARTITION /mnt/boot"
	exit 34
fi

echo -en "\n\n"
echo "Mounted devices."
mount | grep '/mnt/' 
echo -en "\n\n"

exit 0

