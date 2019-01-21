#!/bin/bash -x

clear

# LOAD parameters
source /install/etc/config.sh
cd $MYDIR

# initial setup
timedatectl set-ntp true

# network setup
source $MYDIR/bin/stage1/network.manual.install.sh 

# partitioning
$MYDIR/bin/stage1/partitioning.sh 
# partitioning
$MYDIR/bin/stage1/mounting.sh 

mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.0
cp -p $MYDIR/etc/network/mirrorlist /etc/pacman.d/mirrorlist

pacstrap /mnt  --noconfirm  base mc
genfstab -U /mnt > /mnt/etc/fstab 

cp -rup /install /mnt/install

arch-chroot /mnt /bin/bash -c /install/bin/stage2/install.sh

mv /mnt/etc/resolv.conf /mnt/etc/resolv.conf.0
cp $MYDIR/network/resolv.conf /mnt/etc/resolv.conf

echo "REBOOT???"
read x 
reboot
