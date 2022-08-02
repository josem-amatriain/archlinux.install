#!/bin/bash -x

# LOAD parameters
source /tmp/install/config/config.sh

cat /mnt/etc/resolv.conf > /mnt/etc/resolv.conf.0
cat /etc/resolv.conf >  /mnt/etc/resolv.conf

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

# Actualizar keyring solamente
pacman --noconfirm -Sy archlinux-keyring

pacman -Sy
pacman-key --refresh-keys

# Instalar
pacstrap /mnt --noconfirm base mc btrfs-progs linux-lts base-devel htop linux-firmware

