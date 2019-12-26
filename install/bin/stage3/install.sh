#!/bin/bash

source /install/config/config.sh

for IFACE in $MYDIR/config/ifaces/*.sh
do
    IF0=$(basename $IFACE)
    IF=$( echo $IF0 | cut -d'.' -f1)
    systemctl status network@$IF
done

pacman --noconfirm -Suy
pacman --noconfirm --needed -Sy $PACKAGES $EXTRA_PACKAGES
systemctl status cronie
systemctl start cronie
systemctl enable cronie
systemctl status cronie

# Create group with ID 12345 by default
if [ -n "$GROUP" ]; then 
    if [ -zv"$GROUPID" ]; then 
	GROUPID=12345
    fi
    groupadd -g $GROUPID $GROUP
fi

if [ -n "$USER" ]; then 
    useradd -m -g $GROUPID -G video,wheel,users,$GROUP -s /bin/bash $USER
    echo -en "$PASSWORD\n$PASSWORD\n" > /tmp/borra && passwd $USER < /tmp/borra; rm /tmp/borra
    cp etc/bashrc /home/$USER/.bashrc
fi

# Add user to group:
# usermod -a -G docker user
