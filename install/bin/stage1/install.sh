#!/bin/bash

# LOAD parameters
source /tmp/install/config/config.stage1.sh
cd $MYDIR

# initial setup
timedatectl set-ntp true
timedatectl set-timezone $ZONEINFO

echo -en "\n\n"
echo "Beggining network minimal installation";
echo -en "\n\n"
# network setup
$MYDIR/bin/stage1/network.manual.install.sh 

# partitioning
echo -en "\n\n"
echo "Beggining partition process.";
echo -en "\n\n"

$MYDIR/bin/stage1/partitioning.sh >> $LOG 2>&1

echo -en "\n\n"
echo "Partitions created."
echo -en "\n\n"

# mounting
$MYDIR/bin/stage1/mounting.sh  >> $LOG 2>&1

echo -en "\n\n"
echo "Mounted devices."
mount | grep '/dev/sd'
echo -en "\n\n"

mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.0
cp -p $MYDIR/etc/network/mirrorlist /etc/pacman.d/mirrorlist

echo -en "\n\n"
echo "Begining intallation of packages"
echo -en "\n\n"

$MYDIR/bin/stage1/pacman.sh 

echo -en "\n\n"
echo "Begining chroot."
echo -en "\n\n"

cp -rup /tmp/install /mnt/install
# stage2 must be at /mnt/install... Chroot finds it at /install/...
arch-chroot /mnt /bin/bash -c /install/bin/stage2/install.sh

mv /mnt/etc/resolv.conf /mnt/etc/resolv.conf.0
cp $MYDIR/etc/network/resolv.conf /mnt/etc/resolv.conf
genfstab -U /mnt > /mnt/etc/fstab 

echo "REBOOT please. Then yo must run stage3/install.sh"

