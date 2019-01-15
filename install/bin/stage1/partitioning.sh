#!/bin/bash -x


MYPATH="$MYDIR/etc/gdisk"

for DISK in $( cat $MYDIR/etc/gdisk/disks ); do
	gdisk $DISK < $MYPATH/gdisk.delete.disk
done

INPUTFILE="$MYDIR/etc/gdisk/parts"
exec < $INPUTFILE

while read FS DEVICE TYPE MOUNTPOINT LABEL
do
	PREFIX="/mnt"
	gdisk $DEVICE < $MYDIR/etc/gdisk/gdisk.$TYPE 
	$MYDIR/bin/stage1/format.$FS.sh $DEVICE $FS $TYPE $LABEL
	mkdir -p /mnt$MOINTPOINT
	mount -t $FS $DEVICE /mnt$MOUNTPOINT
	if [ "$TYPE" -eq "boot" ]; then
		echo "BOOT_PARTITION=$DEVICE" > "$MYDIR/etc/boot.partition"
	fi
done


# gdisk /dev/sdd < gdisk.delete.disk
# gdisk /dev/sdd < gdisk.boot
# gdisk /dev/sdd < gdisk.swap
# gdisk /dev/sdd < gdisk.root
