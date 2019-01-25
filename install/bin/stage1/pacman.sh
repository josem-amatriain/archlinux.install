#!/bin/bash -x

ORIGEN="/tmp/sdd1/var.cache.pacman/pkg"
DESTINO="/mnt/var/cache/pacman"
# Install caché
if [ -d $ORIGEN ]; then
	mkdir -p $DESTINO
	rsync  --ignore-errors -au $ORIGEN $DESTINO
fi

pacman -Sy
#pacstrap /mnt --noconfirm archlinux-keyring
#pacman-key --refresh-keys

pacstrap /mnt --noconfirm base mc
#pacstrap /mnt --noconfirm mc

