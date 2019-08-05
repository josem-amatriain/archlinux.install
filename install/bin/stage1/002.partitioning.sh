#!/bin/bash -x

# LOAD parameters
source /tmp/install/config/config.sh

MYPATH="$MYDIR/etc/gdisk"

rm "$MYDIR/etc/*.partition" 2> /dev/null
RES=$( grep boot "$MYDIR/config/config.parts" )
if [ -z "$RES" ]; then
	echo "Error. Not boot partititon."
	exit 1
fi

RES=$( grep root "$MYDIR/config/config.parts" )
if [ -z "$RES" ]; then
	echo "Error. Not root partititon."
	exit 1
fi


source $MYDIR/config/config.disks
for DISK in $DISKS; do
	gdisk $DISK < $MYPATH/gdisk.delete.disk
done

INPUTFILE="$MYDIR/config/config.parts"
exec < $INPUTFILE

while read FS DISK DEVICE TYPE MOUNTPOINT LABEL INI END
do
	PREFIX="/mnt"
#	DISK=$( echo $DEVICE | grep -o '/dev/[a-z]*' )
#	gdisk $DISK < $MYDIR/etc/gdisk/gdisk.$TYPE 
	$MYDIR/bin/stage1/parted.$TYPE.sh $DEVICE $FS $TYPE $LABEL $INI $END $DISK
	# Refreshing partition info
	sync
	partx -u $DISK
	sync
	
	DEVICE2=""  # checking two different ways to compose partition numbers
	if [ -b $DISK$DEVICE    ]; then DEVICE2=$DISK$DEVICE; fi
	if [ -b ${DISK}p$DEVICE ]; then DEVICE2=${DISK}p$DEVICE; fi
	if [ -z "$DEVICE2"      ]; then
		echo "ERROR partition not found $DISK$DEVICE, nor ${DISK}p$DEVICE"
		exit 111 
	fi
	
	$MYDIR/bin/stage1/format.$FS.sh $DEVICE2 $FS $TYPE $LABEL
	sync
#	mkdir -p /mnt$MOUNTPOINT
#	mount -t $FS $DISK$DEVICE /mnt$MOUNTPOINT
	if [ "$TYPE" == "root" ]; then
		echo -en "ROOT_PARTITION=$DEVICE2\nROOT_FS=$FS" > "$MYDIR/etc/root.partition"
	fi
	if [ "$TYPE" == "other" ]; then
		echo "$DEVICE2 $FS $MOUNTPOINT" >> "$MYDIR/etc/other.partition"
	fi
	if [ "$TYPE" == "boot" ]; then
		echo "BOOT_PARTITION=$DEVICE2" > "$MYDIR/etc/boot.partition"
	fi
done

exit 0

# gdisk /dev/sdd < gdisk.delete.disk
# gdisk /dev/sdd < gdisk.boot
# gdisk /dev/sdd < gdisk.swap
# gdisk /dev/sdd < gdisk.root
# Parted syntax:
#	FS-TYPE is one of: btrfs, nilfs2, ext4, ext3, ext2, fat32, fat16, hfsx, hfs+, hfs, jfs, swsusp, linux-swap(v1), linux-swap(v0), ntfs, reiserfs, hp-ufs, sun-ufs, xfs,
#        apfs2, apfs1, asfs, amufs5, amufs4, amufs3, amufs2, amufs1, amufs0, amufs, affs7, affs6, affs5, affs4, affs3, affs2, affs1, affs0, linux-swap, linux-swap(new),
#        linux-swap(old)
#        START and END are disk locations, such as 4GB or 10%.  Negative values count from the end of the disk.  For example, -1s specifies exactly the last sector.
