#!/bin/bash -x

source /tmp/install/config/config.sh
source $MYDIR/etc/root.partition

BOOT_DIR="/mnt/boot"

bootctl --path=$BOOT_DIR install

rm $BOOT_DIR/loader/loader.conf
rm $BOOT_DIR/loader/entries/arch.conf

if [ "$KERNEL" -eq "linux-lts" ]; then
  cp $MYDIR/boot/loader.lts.conf $BOOT_DIR/loader/loader.conf
  cp $MYDIR/boot/arch*.conf   $BOOT_DIR/loader/entries/.
  echo -en "$(blkid -s PARTUUID -o value $ROOT_PARTITION ) rw\n\n" >> $BOOT_DIR/loader/entries/archlts.conf
  echo -en "$(blkid -s PARTUUID -o value $ROOT_PARTITION ) rw\n\n" >> $BOOT_DIR/loader/entries/arch.conf
else
  cp $MYDIR/boot/loader.conf $BOOT_DIR/loader/loader.conf
  cp $MYDIR/boot/arch.conf   $BOOT_DIR/loader/entries/arch.conf
  echo -en "$(blkid -s PARTUUID -o value $ROOT_PARTITION ) rw\n\n" >> $BOOT_DIR/loader/entries/arch.conf
fi

bootctl --path=$BOOT_DIR install

mv /mnt/etc/resolv.conf > /mnt/etc/resolv.conf.0
cp $MYDIR/etc/network/resolv.conf >  /mnt/etc/resolv.conf
