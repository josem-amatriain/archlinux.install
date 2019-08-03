#!/bin/bash -x

source /tmp/install/config/config.stage1.sh
cd $MYDIR
source $MYDIR/etc/root.partition

BOOT_DIR="/mnt/boot"

rm $BOOT_DIR/loader/loader.conf
rm $BOOT_DIR/loader/entries/arch.conf

cp $MYDIR/boot/loader.conf $BOOT_DIR/loader/loader.conf
cp $MYDIR/boot/arch.conf   $BOOT_DIR/loader/entries/arch.conf
echo -en "$(blkid -s PARTUUID -o value $ROOT_PARTITION ) rw\n\n" >> $BOOT_DIR/loader/entries/arch.conf

bootctl --path=$BOOT_DIR install
