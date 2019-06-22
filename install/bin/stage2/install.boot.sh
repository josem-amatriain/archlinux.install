#!/bin/bash -x

source /install/config/config.stage2.sh
cd $MYDIR

rm /boot/loader/loader.conf
cp boot/loader.conf /boot/loader/loader.conf
cp boot/arch.conf /boot/loader/entries/arch.conf

bootctl --path=/boot install

source $MYDIR/etc/root.partition

echo -en "$(blkid -s PARTUUID -o value $ROOT_PARTITION ) rw\n\n" >> /boot/loader/entries/arch.conf
