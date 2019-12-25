#!/bin/bash -x

clear


echo "Now you can see if UEFI is OK. Press enter: "
read x
ls /sys/firmware/efi/efivars
read x

clear

PASS=$1
shift
if [ -z "$PASS" ]; then
    PASS="123456"
fi

timedatectl set-ntp true
echo -e "$PASS\n$PASS\n" | passwd

#wget https://linkfox.io/instarchtargz -O /tmp/branch.tar.gz
wget https://github.com/josem-amatriain/archlinux.install/archive/master.tar.gz  -O /tmp/branch.tar.gz
read x

cd /tmp/; tar xvf /tmp/branch.tar.gz
mv /tmp/archlinux.install-master/install /tmp/.
systemctl start sshd

echo "Now you can login to this host via ssh and finish de installation proccess.
Press enter to see your ip address, and use ssh root@xxx.xxx.xxx.xxx to login.
The installation scripts are at /tmp/archlinux.install-master
default password is $PASS
If network device is not set up you must execute scripts manually:"
ip addr show | grep inet | grep -v inet6 | grep -v 127
read x

