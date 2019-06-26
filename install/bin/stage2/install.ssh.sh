#!/bin/bash

source /install/config/config.stage2.sh
cd $MYDIR

pacman --needed --noconfirm -S openssh

cp -p /etc/ssh/sshd_config /etc/ssh/sshd_config.0
echo -en "$CONFIG_SSH" >> /etc/ssh/sshd_config

systemctl enable sshd
systemctl start sshd


