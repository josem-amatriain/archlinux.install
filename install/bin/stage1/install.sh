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
if [ -z "$DEBUG" ]; then true
    else echo "Beggining partition process?? Enter to continue..."; read x; clear
fi
clear
$MYDIR/bin/stage1/partitioning.sh 

if [ -z "$DEBUG" ]; then true
else
echo "Partitions created. Enter to continue"
read x
fi
clear
# mounting
$MYDIR/bin/stage1/mounting.sh 

if [ -z "$DEBUG" ]; then true
else
    mount | grep '/dev/sd'
    echo "Mounted devices? . Enter to continue"
    read x
    clear
fi

mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.0
cp -p $MYDIR/etc/network/mirrorlist /etc/pacman.d/mirrorlist
genfstab -U /mnt > /mnt/etc/fstab 
cp -rup /install /mnt/install

if [ -z "$DEBUG" ]; then true
else
    echo "Begining intallation of packages. Enter to continue"
    read x
fi
clear

$MYDIR/bin/stage1/pacman.sh 

if [ -z "$DEBUG" ]; then true
else
    echo "Installation of packages DONE?. Begining chroot: Enter to continue"
    read x
    clear
fi

arch-chroot /mnt /bin/bash -c /install/bin/stage2/install.sh

mv /mnt/etc/resolv.conf /mnt/etc/resolv.conf.0
cp $MYDIR/etc/network/resolv.conf /mnt/etc/resolv.conf

echo "REBOOT???"
read x 
reboot
