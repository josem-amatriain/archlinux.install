#!/bin/bash -x

clear

#cd /tmp
#
#wget https://codeload.github.com/josem-amatriain/archlinux.install/archive/master.tar.gz
#mv archlinux.install-master/install /tmp/install

cd /tmp/install

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
gdisk -l $PARTICION
read x

gdisk $PARTICION < disk/com2
gdisk -l $PARTICION
read x
clear

mkfs.fat -F32 ${PARTICION}1
mkswap ${PARTICION}2
swapon ${PARTICION}2

mkfs.ext4 ${PARTICION}3
mount ${PARTICION}3 /mnt
mkdir /mnt/boot
mount ${PARTICION}1 /mnt/boot

mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.0
cp -p network/mirrorlist /etc/pacman.d/mirrorlist

read x
clear

pacstrap -i /mnt base mc openssh net-tools gdisk
genfstab -U /mnt > /mnt/etc/fstab 
cp -rup /tmp/install /mnt/install
read x
clear

arch-chroot /mnt /bin/bash -c /install/install2.sh


