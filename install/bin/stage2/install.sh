#!/bin/bash

clear

MYDIR="/install"
source $MYDIR/etc/config.stage2.sh
cd $MYDIR

pacman --noconfirm  -Sy archlinux-keyring
#pacman-key --refresh-keys

# INSTALLING BOOT
$MYDIR/bin/stage2/install.boot.sh 

# INSTALLING LOCALES
$MYDIR/bin/stage2/install.locales.sh 

# INSTALLING DATE TIME
$MYDIR/bin/stage2/install.time.sh 

# INSTALLING NETWORK
$MYDIR/bin/stage2/install.network.sh

echo "Changing root password"
echo -en "$PASSWORD\n$PASSWORD\n" > /tmp/borra && passwd < /tmp/borra; rm /tmp/borra


$MYDIR/bin/stage2/install.ssh.sh

# INSTALLING home
cp /etc/skel/.bash_profile /root/.
sed -e 's/\"$GREEN\"/\"\$RED\"/g' etc/bashrc > /root/.bashrc
