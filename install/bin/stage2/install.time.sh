

rm -f /etc/localtime
ln -s /usr/share/zoneinfo/$ZONEINFO /etc/localtime
hwclock --systohc --utc
