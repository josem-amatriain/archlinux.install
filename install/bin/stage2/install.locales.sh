#!/bin/bash -x 


echo "$VCONSOLE" > /etc/vconsole.conf

mv /etc/locale.gen /etc/locale.gen.0
echo "$LOCALEGEN" > /etc/locale.gen
locale-gen

#echo -en "\nLANG=$LANG\n" >> /etc/locale.conf
echo "$LOCALECONF" >> /etc/locale.conf

pacman --noconfirm -S terminus-font
