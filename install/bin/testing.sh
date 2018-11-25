#!/bin/bash

clear


MYDIR="/install"

echo "$MYDIR==="

source $MYDIR/etc/config.sh
source $MYDIR/etc/config.net.sh
source $MYDIR/etc/config.post.sh

echo arch-chroot /mnt

if [ -a "$MYDIR/etc/bashrc.0" ]; then 
    source $MYDIR/etc/bashrc.0
else
    echo "bashrc no se encuentra"
    exit 1
fi

DEF=$DEFAULT

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

echo -en "\n\n   $BLUE Network confign$DEF.\n\n"
systemctl status network@*

echo -en "\n\n\n\n"

echo -en "\n\n   $BLUE Routing table $DEF.\n\n"
ip route show
read x
clear

echo -en "\n\n   $BLUE IPs $DEF.\n\n"
ip addr show

echo -en "\n\n\n\n"
echo -en "\n\n   $BLUE DNS resolving $DEF.\n\n"


cat /etc/resolv.conf
read x
clear

echo -en "\n\n   $BLUE Disk partitions: $DEF.\n\n"
fdisk -l $PARTICION
gdisk -l $PARTICION

echo -en "\n\n   $BLUE Partition sizes $DEF.\n\n"
df -h
read x 
clear

echo -en "\n\n   $BLUE FSTAB $DEF.\n\n"
cat /etc/fstab
echo -en "\n\n\n\n"

echo -en "\n\n   $BLUE pacman mirrors and install folder: $DEF.\n\n"
ls -l /etc/pacman.d/mirror*
ls -la /install

read x
clear

echo -en "\n\n   $BLUE Booting config $DEF.\n\n"
cat /boot/loader/loader.conf

echo -en "\n\n\n\n"

echo -en "\n\n   $BLUE arch entry:$DEF.\n\n"
cat /boot/loader/entries/arch.conf

read x 
clear

echo -en "\n\n   $BLUE vconsole locale.conf locale.gen & localtime $DEF.\n\n"
cat /etc/vconsole.conf /etc/locale.conf /etc/locale.gen
ls -l /etc/localtime
read x 
clear

echo -en "\n\n   $BLUE Users & groups $DEF.\n\n"
grep $USER /etc/passwd
grep $GROUPID /etc/group
read x
clear
echo -en "\n\n   $BLUE ssh config $DEF.\n\n"
grep -v '^#' /etc/ssh/sshd_config | grep -v '^$'
systemctl status sshd
echo -en "\n\n   $BLUE services: $DEF.\n\n"
netstat -tulnp 
read x
clear
echo -en "\n\n   $BLUE SystemCTL Network settings $DEF.\n\n"
ls -l /etc/systemd/system /etc/conf.d/
for IFACE in $MYDIR/network/ifaces/*.sh
do
    IF0=$(basename $IFACE)
    IF=$( echo $IF0 | cut -d'.' -f1)
    systemctl status network@$IF
done
read x

