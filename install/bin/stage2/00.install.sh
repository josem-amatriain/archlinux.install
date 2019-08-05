#!/bin/bash -x

clear

MYDIR="/install"
source $MYDIR/config/config.sh

pacman --noconfirm  -Sy archlinux-keyring
#pacman-key --refresh-keys

# INSTALLING BOOT
# $MYDIR/bin/stage2/install.boot.sh

# INSTALLING LOCALES
$MYDIR/bin/stage2/01.install.locales.sh

# INSTALLING DATE TIME
$MYDIR/bin/stage2/02.install.time.sh

# INSTALLING NETWORK
$MYDIR/bin/stage2/03.install.network.sh

echo "Changing root password"
echo -en "$PASSWORD\n$PASSWORD\n" > /tmp/borra && passwd < /tmp/borra; rm /tmp/borra

# SSHD
$MYDIR/bin/stage2/04.install.ssh.sh

# INSTALLING home
cp /etc/skel/.bash_profile /root/.
sed -e 's/\"$GREEN\"/\"\$RED\"/g' $MYDIR/etc/bashrc > /root/.bashrc
