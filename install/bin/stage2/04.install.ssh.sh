#!/bin/bash

source /install/config/config.sh

pacman --needed --noconfirm -S openssh

SSHD_CONF="/etc/ssh/sshd_config"

cp -p $SSHD_CONF $SSHD_CONF.0
grep -v '^$' $SSHD_CONF.0 | grep -v '^#' > $SSHD_CONF
echo -en "$CONFIG_SSH" >> $SSHD_CONF

systemctl enable sshd
systemctl start sshd
