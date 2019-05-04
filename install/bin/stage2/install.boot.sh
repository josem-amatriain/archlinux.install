#!/bin/bash -x

source /install/config/config.stage2.sh
cd $MYDIR

bootctl --path=/boot install

rm /boot/loader/loader.conf
cp boot/loader.conf /boot/loader/loader.conf
cp boot/arch.conf /boot/loader/entries/arch.conf

source $MYDIR/etc/root.partition

echo -en "$(blkid -s PARTUUID -o value $ROOT_PARTITION ) rw\n\n" >> /boot/loader/entries/arch.conf
