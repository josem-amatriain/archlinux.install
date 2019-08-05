#!/bin/bash -x 


source /install/config/config.sh

pacman --needed --noconfirm -S terminus-font &

mv /etc/vconsole.conf /etc/vconsole.0.conf
echo "$VCONSOLE" > /etc/vconsole.conf

mv /etc/locale.gen /etc/locale.0.gen
echo "$LOCALEGEN" > /etc/locale.gen
locale-gen

#echo -en "\nLANG=$LANG\n" >> /etc/locale.conf
mv /etc/locale.conf /etc/locale.0.conf
echo "$LOCALECONF" >> /etc/locale.conf
