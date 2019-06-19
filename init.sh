#!/bin/bash


echo "The usb device: "
df -h | grep 'sd[e-z]'
dmesg | grep 'sd.: sd.[1-9]' | grep -v 'sd[a-d]'


echo " Parameters:
 First  $1 = device for usb. Example: e1 f1 g2 h1...
 Second $2 = password, if not fedined, '123456' will be used. this '\' is not a valid character.
"

mkdir -p /tmp/usb


if ! [ -b /dev/sd$1 ]; then
    echo "Give me the correct parameters. 
    /dev/sd$1 Is not a correct device"
    exit 0
fi

mount /dev/sd$1 /tmp/usb 
shift

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
If the network devide is not setup you must execute manual scripts:"
read x 

ip addr show | grep inet | grep -v inet6 | grep -v 127

wget https://linkfox.io/instarchtargz -O /tmp/branch.tar.gz
cd /tmp/; tar xvf /tmp/branch.tar.gz
mv /tmp/archlinux.install-master/install /tmp/.
systemctl start sshd

