pacman -Syu
pacman -S --needed --noconfirm xorg-server xorg-xinit mesa mesa-demos xf86-video-intel
pacman -S  --needed --noconfirm intel-ucode
pacman -S  --needed --noconfirm cinnamon cinnamon-translations terminator
pacman -S  --needed --noconfirm gdm
systemctl enable gdm


reboot
