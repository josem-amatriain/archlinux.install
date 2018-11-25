#!/bin/bash -x

clear

# wget https://github.com/josem-amatriain/archlinux.install/archive/master.tar.gz
#mv archlinux.install-master/install /install

cd /install

# LOAD parameters
source etc/config.sh
source etc/config.net.sh

# initial setup
timedatectl set-ntp true

ping -c1 archlinux.org
if [ $? -eq 0 ]; then true; else 
    mv /etc/resolv.conf /etc/resolv.conf.0
    cp network/resolv.conf /etc/resolv.conf

    ip route show 
    ip route add default via $GW
    ip route show 
    
    ping -c5 archlinux.org
    read x
fi

parted $PARTICION < disk/parted
#gdisk -l $PARTICION
gdisk $PARTICION < disk/com2
gdisk -l $PARTICION

mkfs.fat -F32 ${PARTICION}1
mkswap ${PARTICION}2
swapon ${PARTICION}2

mkfs.ext4 ${PARTICION}3
mount ${PARTICION}3 /mnt
mkdir /mnt/boot
mount ${PARTICION}1 /mnt/boot

mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.0
cp -p network/mirrorlist /etc/pacman.d/mirrorlist

pacstrap -i /mnt base mc
genfstab -U /mnt > /mnt/etc/fstab 
cp -rup /install /mnt/install

arch-chroot /mnt /bin/bash -c /install/install2.sh


