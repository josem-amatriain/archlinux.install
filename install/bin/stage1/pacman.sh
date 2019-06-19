#!/bin/bash -x

ORIGEN="$PACMAN_CACHE_PATH"
DESTINO="/mnt/var/cache/pacman"
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

pacstrap /mnt --noconfirm base mc
#pacstrap /mnt --noconfirm mc

