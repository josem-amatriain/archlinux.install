pacman -Syu
pacman -S xorg-server xorg-xinit mesa mesa-demos xf86-video-intel
pacman -S intel-ucode
pacman -S cinnamon
pacman -S gdm
systemctl enable gdm


reboot