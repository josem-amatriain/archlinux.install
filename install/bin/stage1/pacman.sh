#!/bin/bash -x

pacman -Sy
#pacstrap /mnt --noconfirm archlinux-keyring
#pacman-key --refresh-keys

pacstrap /mnt --noconfirm base
#pacstrap /mnt --noconfirm mc

