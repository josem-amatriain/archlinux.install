#!/bin/bash

clear


MYDIR="/tmp/install"

echo "$MYDIR==="

source $MYDIR/etc/config.sh
MYDIR="/tmp/install"
source $MYDIR/etc/config.net.sh
MYDIR="/tmp/install"
source $MYDIR/etc/config.post.sh
MYDIR="/tmp/install"

echo arch-chroot /mnt

if [ -a "$MYDIR/etc/bashrc" ]; then 
    source $MYDIR/etc/bashrc
else
    echo "bashrc no se encuentra"
    exit 1
fi

echo -en "\n\n   $BLUE Testing installation$DEF.\n\n"
echo -en "\n Testing system datetime: $GREEN $(date) $DEF\n"

echo -en "\n\n\n\n"
echo -en "\n Testing network: GW=$GW IP=$MYIP HOSTNAME=$HOSTNAME\n"
hostname
read x
clear
ping -c1 $GW
if [ $? -eq 0 ]; then 
    echo -e "$GREEN $GW OK$DEF Gateway riched"; 
else 
    echo -e "$RED NO $GW Gateway riched$DEF"; 
    exit 1
fi

ping -c1 archlinux.org
if [ $? -eq 0 ]; then 
    echo -e "$GREEN OK$DEF INTERNET riched"; 
else 
    echo -e "$RED NO INTERNET riched$DEF"; 
    exit 1
fi
read x 
clear
systemctl status network@*

echo -en "\n\n\n\n"

ip route show
read x
clear
ip addr show

echo -en "\n\n\n\n"



cat /etc/resolv.conf
read x
clear
fdisk -l $PARTICION
gdisk -l $PARTICION
df -h
read x 
clear
cat /etc/fstab
echo -en "\n\n\n\n"

ls -l /etc/pacman.d/mirror*
ls -la /install

read x
clear

cat /boot/loader/loader.conf

echo -en "\n\n\n\n"
cat /boot/loader/entries/arch.conf

read x 
clear
cat /etc/vconsole.conf /etc/locale.conf /etc/locale.gen
ls -l /etc/localtime
read x 
clear
grep $USER /etc/passwd
grep $GROUPID /etc/group
read x
clear
tail -9 /etc/ssh/sshd_config
systemctl status sshd
netstat -tulnp 
read x
clear
ls -l /etc/systemd/system /etc/conf.d/
for IFACE in $MYDIR/network/ifaces/*.sh
do
    IF0=$(basename $IFACE)
    IF=$( echo $IF0 | cut -d'.' -f1)
    echo systemctl status network@$IF
done
read x

