#!/bin/bash -x


cd /install 

cp  etc/vconsole.conf /etc/vconsole.conf

mv /etc/locale.gen /etc/locale.gen.0
cp etc/locale.gen /etc/locale.gen
locale-gen


echo -en '\nLANG=es_ES.UTF-8\n' >> /etc/locale.conf


echo -en "\n$HOSTNAME\n" > /etc/hostname

echo -en "\n127.0.0.1  localhost.localdomain localhost\n$MYIP $HOSTNAME\n" >> /etc/hosts


rm -f /etc/localtime
ln -s /usr/share/zoneinfo/Europe/Madrid /etc/localtime
hwclock --systohc --utc


# Create group with ID 12345 by default
if [ -n "$GROUP" ]; then 
    if [ -zv"$GROUPID" ]; then 
	GROUPID=12345
    fi
    groupadd -g $GROUPID $GROUP
fi

if [ -n "USER" ]; then 
    useradd -m -g $GROUPID -G wheel,users,$GROUP -s /bin/bash $USER
    passwd $USER
    cp etc/bashrc /home/$USER/.bashrc
fi

passwd

