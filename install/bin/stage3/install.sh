#!/bin/bash

MYDIR="/install"
cd $MYDIR

source $MYDIR/etc/config.sh
source $MYDIR/etc/config.stage3.sh

for IFACE in $MYDIR/etc/network/ifaces/*.sh
do
    IF0=$(basename $IFACE)
    IF=$( echo $IF0 | cut -d'.' -f1)
    systemctl status network@$IF
done

pacman --noconfirm -Suy
pacman --noconfirm -Sy $PACKAGES

# Create group with ID 12345 by default
if [ -n "$GROUP" ]; then 
    if [ -zv"$GROUPID" ]; then 
	GROUPID=12345
    fi
    groupadd -g $GROUPID $GROUP
fi

if [ -n "$USER" ]; then 
    useradd -m -g $GROUPID -G wheel,users,$GROUP -s /bin/bash $USER
    passwd $USER
    cp etc/bashrc /home/$USER/.bashrc
fi

# Add user to group:
# usermod -G docker user
