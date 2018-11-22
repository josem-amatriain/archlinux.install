#!/bin/bash -x

cd /install 
source etc/config.sh

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

passwd

