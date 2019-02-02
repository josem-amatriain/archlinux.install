#!/bin/bash -x

pacman --noconfirm -S base-devel expac git pyalpm python-regex sudo  --needed

pacman --noconfirm -S --asdeps go

echo "user ALL=(ALL) ALL" >> /etc/sudoers

echo "Como usuario
su - user

cd /tmp/
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

# /usr/bin/pacman -U /tmp/yay/yay-9.0.1-3-x86_64.pkg.tar.x
"
su - user