#!/bin/bash -x

pacman --noconfirm   --needed -S base-devel expac git pyalpm python-regex sudo

pacman --noconfirm  --needed -S --asdeps go

echo "user ALL=(ALL) ALL" >> /etc/sudoers

echo "Como usuario
su - user

cd /tmp/
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

# /usr/bin/pacman -U /tmp/yay/yay-9.0.1-3-x86_64.pkg.tar.x
"
su - user
