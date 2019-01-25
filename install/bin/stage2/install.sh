#!/bin/bash

clear

MYDIR="/install"

cd $MYDIR

source $MYDIR/etc/config.sh
MYDIR="/install"
source $MYDIR/etc/config.post.sh
MYDIR="/install"

pacman --noconfirm  -Sy archlinux-keyring
#pacman-key --refresh-keys


# INSTALLING BOOT
source $MYDIR/bin/stage2/install.boot.sh 

# INSTALLING LOCALES
source $MYDIR/bin/stage2/install.locales.sh 

# INSTALLING DATE TIME
source $MYDIR/bin/stage2/install.time.sh 

# INSTALLING NETWORK
$MYDIR/bin/stage2/install.network.sh



echo "Changing root password:"
passwd

$MYDIR/bin/stage2/install.ssh.sh

# INSTALLING home
cp /etc/skel/.bash_profile /root/.
sed -e 's/\"$GREEN\"/\"\$RED\"/g' etc/bashrc > /root/.bashrc
