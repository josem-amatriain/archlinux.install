#!/bin/bash -x

bootctl --path=/boot install

rm /boot/loader/loader.conf
cp boot/loader.conf /boot/loader/loader.conf
cp boot/arch.conf /boot/loader/entries/arch.conf

source $MYDIR/etc/boot.partition

echo -en "$(blkid -s PARTUUID -o value $BOOT_PARTITION ) rw\n\n" >> /boot/loader/entries/arch.conf