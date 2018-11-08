#!/bin/bash -x

clear

cd /install

source etc/config.sh



bootctl --path=/boot install

rm /boot/loader/loader.conf
cp loader.conf /boot/loader/loader.conf
cp arch.conf /boot/loader/entries/arch.conf

blkid -s PARTUUID -o value ${PARTICION}3 >> /boot/loader/entries/arch.conf
echo -en " rw\n\n" >> /boot/loader/entries/arch.conf

/install/network/install.network.sh

pacman -Suy 
pacman -Sy git networkmanager wireless_tools unzip bzip2 pbzip2 parted
# base-devel

