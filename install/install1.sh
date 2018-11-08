#!/bin/bash -x

clear

#cd /tmp

#curl https://codeload.github.com/josem-amatriain/archlinux.install/zip/master --output master.zip
#unzip master.zip
#mv archlinux.install-master/install /tmp/install

cd /tmp/install

source etc/config.sh

rm /etc/resolv.conf
cp network/resolv.conf /etc/resolv.conf
ip route show 
ip route add default via $GW
ip route show 

ping -c5 archlinux.org
read x

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

read x
clear

pacstrap -i /mnt base mc openssh net-tools gdisk
genfstab -U /mnt > /mnt/etc/fstab 
cp -p /tmp/install /mnt/install
read x
clear

arch-chroot /mnt /bin/bash 

