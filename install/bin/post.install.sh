#!/bin/bash -x

MYDIR="/install"
cd $MYDIR

mv /etc/resolv.conf /etc/resolv.conf.0
cp $MYDIR/network/resolv.conf /etc/resolv.conf

systemctl enable sshd
systemctl start sshd


source etc/config.sh
source etc/config.post.sh

for IFACE in $MYDIR/network/ifaces/*.sh
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

cp /etc/skel/.bash_profile /root/.

sed -e 's/\"$GREEN\"/\"\$RED\"/g' etc/bashrc > /root/.bash_profile
