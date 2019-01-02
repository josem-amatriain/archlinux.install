#!/bin/bash -x

pacman --noconfirm -S ntp

echo -e "\nserver hora.rediris.es iburst\nserver pulsar.rediris.es iburst\n" >> /etc/ntp.conf


systemctl enable ntpd
systemctl start ntpd


ntpq -np

