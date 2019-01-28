#!/bin/bash -x 


source /install/etc/config.stage2.sh
source $MYDIR/etc/config.stage2.locale.sh
cd $MYDIR

echo "$VCONSOLE" > /etc/vconsole.conf

mv /etc/locale.gen /etc/locale.gen.0
echo "$LOCALEGEN" > /etc/locale.gen
locale-gen

#echo -en "\nLANG=$LANG\n" >> /etc/locale.conf
echo "$LOCALECONF" >> /etc/locale.conf

pacman --noconfirm -S terminus-font
