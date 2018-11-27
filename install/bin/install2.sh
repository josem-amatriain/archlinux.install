#!/bin/bash -x

clear

cd /install

source etc/config.sh
source etc/config.net.sh

bootctl --path=/boot install

rm /boot/loader/loader.conf
cp boot/loader.conf /boot/loader/loader.conf
cp boot/arch.conf /boot/loader/entries/arch.conf

echo -en "$(blkid -s PARTUUID -o value ${PARTICION}3) rw\n\n" >> /boot/loader/entries/arch.conf

echo "$VCONSOLE" > /etc/vconsole.conf

mv /etc/locale.gen /etc/locale.gen.0
echo "$LOCALEGEN" > /etc/locale.gen
locale-gen

#echo -en "\nLANG=$LANG\n" >> /etc/locale.conf
echo "$LOCALECONF" >> /etc/locale.conf

rm -f /etc/localtime
ln -s /usr/share/zoneinfo/$ZONEINFO /etc/localtime
hwclock --systohc --utc

pacman --noconfirm -S terminus-font openssh

/install/bin/install.network.sh
echo "Changing root password:"
passwd

/install/bin/install.ssh.sh

cp /etc/skel/.bash_profile /root/.
sed -e 's/\"$GREEN\"/\"\$RED\"/g' etc/bashrc > /root/.bash_profile
