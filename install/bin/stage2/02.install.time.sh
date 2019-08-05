#!/bin/bash -x

source /install/config/config.sh

rm -f /etc/localtime
ln -s /usr/share/zoneinfo/$ZONEINFO /etc/localtime
hwclock --systohc --utc
