#!/bin/bash

source /install/config/config.stage2.sh
cd $MYDIR

pacman --noconfirm -S openssh

#echo -en "\n\nPasswordAuthentication yes\nPermitRootLogin yes\n" > /etc/ssh/sshd_config
echo -en "$CONFIG_SSH" > /etc/ssh/sshd_config

systemctl enable sshd
systemctl start sshd


