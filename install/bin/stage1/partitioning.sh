#!/bin/bash -x


MYPATH="$MYDIR/etc/gdisk"

source $MYPATH/disks
for DISK in $DISKS; do
	gdisk $DISK < $MYPATH/gdisk.delete.disk
done

INPUTFILE="$MYDIR/etc/gdisk/parts"
exec < $INPUTFILE

while read FS DISK DEVICE TYPE MOUNTPOINT LABEL INI END
do
	PREFIX="/mnt"
#	DISK=$( echo $DEVICE | grep -o '/dev/[a-z]*' )
#	gdisk $DISK < $MYDIR/etc/gdisk/gdisk.$TYPE 
	$MYDIR/bin/stage1/parted.$TYPE.sh $DEVICE $FS $TYPE $LABEL $INI $END
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
# Parted syntax:
#	FS-TYPE is one of: btrfs, nilfs2, ext4, ext3, ext2, fat32, fat16, hfsx, hfs+, hfs, jfs, swsusp, linux-swap(v1), linux-swap(v0), ntfs, reiserfs, hp-ufs, sun-ufs, xfs,
#        apfs2, apfs1, asfs, amufs5, amufs4, amufs3, amufs2, amufs1, amufs0, amufs, affs7, affs6, affs5, affs4, affs3, affs2, affs1, affs0, linux-swap, linux-swap(new),
#        linux-swap(old)
#        START and END are disk locations, such as 4GB or 10%.  Negative values count from the end of the disk.  For example, -1s specifies exactly the last sector.
