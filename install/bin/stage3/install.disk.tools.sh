#!/bin/bash -x

pacman --noconfirm -S parted  btrfs-progs ntp

systemctl enable docker
systemctl start docker


