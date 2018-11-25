#!/bin/bash -x

cd /install 
source etc/config.sh
source etc/config.post.sh

/install/network/install.network.sh

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

passwd

sed -e 's/\"$GREEN\"/\"\$RED\"/g' etc/bashrc > /root/.bash_profile

echo -en "\n\nPasswordAuthentication yes\nPermitRootLogin yes\n" > /etc/ssh/sshd_config
systemctl enable sshd
systemctl start sshd


