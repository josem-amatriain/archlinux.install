#!/bin/bash -x

pacman --noconfirm -S docker docker-compose

systemctl enable docker
systemctl start docker

echo "Falta añadir usuarios al grupo docker"

