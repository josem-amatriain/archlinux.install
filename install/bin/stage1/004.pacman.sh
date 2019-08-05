#!/bin/bash -x

# LOAD parameters
source /tmp/install/config/config.sh

mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.0
if [ -z "$REPO" ]; then
	cp -p $MYDIR/etc/network/mirrorlist /etc/pacman.d/mirrorlist
else
	echo $REPO >> /etc/pacman.d/mirrorlist
	cat $MYDIR/etc/network/mirrorlist >> /etc/pacman.d/mirrorlist
fi


ORIGEN="$PACMAN_CACHE_PATH"
DESTINO="/mnt/var/cache/pacman/pkg"

# Install caché
if [ -d $ORIGEN ]; then
	mkdir -p $DESTINO
	rsync  --ignore-errors -au $ORIGEN $DESTINO
else
	echo "Caché PATH $PACMAN_CACHE_PATH is empty. Ignoring caché."
fi

pacman -Sy
#pacstrap /mnt --noconfirm archlinux-keyring
#pacman-key --refresh-keys

pacstrap /mnt --noconfirm base mc btrfs-progs
#pacstrap /mnt --noconfirm mc

