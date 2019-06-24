#!/bin/bash -x

pacman  --needed --noconfirm  -S docker docker-compose

systemctl enable docker
systemctl start docker

echo "Falta añadir usuarios al grupo docker"

