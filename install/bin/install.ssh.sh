#!/bin/bash -x

pacman --noconfirm -S openssh

echo -en "\n\nPasswordAuthentication yes\nPermitRootLogin yes\n" > /etc/ssh/sshd_config
systemctl enable sshd
systemctl start sshd


