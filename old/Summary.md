# Summary

1. [Set keyboard + network](https://github.com/josem-amatriain/archlinux.install#installing-network-manual-mode#keyboard)
1. [Download tag.gz + decompress ](https://github.com/josem-amatriain/archlinux.install#boot)
1. [Set config](https://github.com/josem-amatriain/archlinux.install#keyboard)
1. [Install](https://github.com/josem-amatriain/archlinux.install#install)

# STEPS

1. Start USB
1. Prepare external access 
```ip addr show
# The system has obtained ip by DHCP!!
systemctl start sshd
passwd

# From remote computer:
ssh-keygen -R  192.168.1.2
ssh root@192.168.1.2
wget https://github.com/josem-amatriain/archlinux.install/archive/master.tar.gz

# you must decompress and put the install directory at /install
/install/bin/install1.sh 
```

# REBOOT

1. reboot
1. Log IN as root without password
1. cd /install
1. ./bin/post.install.sh


