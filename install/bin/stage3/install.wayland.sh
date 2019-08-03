pacman -Syu
pacman -S --needed weston xorg-server-xwayland qt5-wayland plasma-wayland-session gst-libav gst-plugins-ugly gst-plugins-bad gst-plugins-espeak gst-transcoder plasma plasma-meta kdebase-meta kdeadmin-meta kdegraphics-meta kdemultimedia-meta kdenetwork-meta kdepim-meta dolphin-plugins kompare kdeutils-meta cronie 

pacman -S --noconfirm  gdm

# localectl set-x11-keymap es pc105 ,es grp:alt_shift_toggle,terminate:ctrl_alt_bksp
# ~/.config/weston.ini

systemctl enable gdm
systemctl status gdm
systemctl start gdm


