#!/bin/bash -x

loadkeys es
echo -en "123456\n123456\n" > /tmp/borra && passwd < /tmp/borra; rm /tmp/borra
systemctl start sshd

#wget https://linkfox.io/branch -O /branch.tar.gz ; mc /
#wget https://linkfox.io/instarchtargz
