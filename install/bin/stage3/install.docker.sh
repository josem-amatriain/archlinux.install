#!/bin/bash -x

pacman --noconfirm -S docker

systemctl enable docker
systemctl start docker


