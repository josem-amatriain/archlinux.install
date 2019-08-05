#!/bin/bash -x


PASS=$1
shift
if [ -z "$PASS" ]; then
    PASS="123456"
fi


echo "Now you can see if UEFI is OK. Press enter: "
read x
ls /sys/firmware/efi/efivars

timedatectl set-ntp true
echo -e "$PASS\n$PASS\n" | passwd

echo "Now you can login to this host via ssh and finish de installation proccess.
Press enter to see your ip address, and use ssh root@xxx.xxx.xxx.xxx to login.
The installation scripts are at /tmp/archlinux.install-master
If network device is not set up you must execute scripts manually:"
read x 

ip addr show | grep inet | grep -v inet6 | grep -v 127

wget https://linkfox.io/instarchtargz -O /tmp/branch.tar.gz
cd /tmp/; tar xvf /tmp/branch.tar.gz
mv /tmp/archlinux.install-master/install /tmp/.
systemctl start sshd

