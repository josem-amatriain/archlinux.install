# archlinux.install
Scripts for arch linux automtic installation.

# Install ARCHLINUX


## Steps
 
 * Creating a bootable archlinux usb
 * Booting and setting up keyboard/console fonts
 * Setting up network manually
 * Patiotioning and setting UEFI boot
 * Initial minimal installation
 * Rebooting and complete installation using git

## Download this repository
 * https://linkfox.io/instarchtargz
 * wget https://linkfox.io/branch -O branch.tar.gz

## To create a bootable archlinux usb
[Download a Archlinux bootable iso](https://www.archlinux.org/download/) image and write to a bootable USB device:

```
dd bs=4M if=/tmp/archlinux.iso of=/dev/sdh && sync
```

## BOOT


1. Set BIOS to boot using UEFI.

Press F12 to choose the boot device. We must choose UEFI boot from USB

1. If the USB device is not detected then the boot image says: Waiting 30 seconds...
You must unplug and plug the usb device. The device will be recognized and you can continue.

1. If your screen is a modern one, with very high resolution, the console text will be unredable. You must change console font:

```
setfont iso01-12x22.psfu.gz
# or simply
setfont iso01-12x22
# others: ls -l /usr/share/kbd/consolefonts
setfont Lat2-Terminus16
``` 
The fonts are available after installation at /usr/share/fonts/local/
The /etc/vconsole file sets the console font in the installed system, after reboot. More fonts are available in the postinstallation process. 
```
pacman -Sy terminus-font 
pacman -Ql terminus-font
setfont ter-v32n
```

But now, this is not important for our immediate purpose that is to begin the installation.

## Keyboard

```
# Setting the keyboard languaje (we choose the one that corresponds) : 
loadkeys es
loadkeys fr
loadkeys uk

```
[Loadkeys](https://wiki.archlinux.org/index.php/Linux_console/Keyboard_configuration#Loadkeys)


## Installing network manual mode

You must change the network device name (eth0) to match your system (for example, enp1s0).  

```
ip addr add 192.168.1.444/24 dev eth0
ip route show 
ip route add default via 192.168.1.1
# RESET
ip addr flush dev eth0
ip link set enp1s0 down
ip link set enp1s0 up

echo -en "\nnameserver 8.8.4.4\n" >> /etc/resolv.conf

ping archlinux.org
```

Now, we can use remote scripts from our repository.


```
timedatectl set-ntp true
systemctl start sshd 
passwd 123456
123456
```

You have two machines, the machine on which you are going to install and the desktop/personal machine.
You must download the repository with git in your personal machine and transfer it compressed to the instalation machine. 
Or you can download in the installation machine using ```wget``` as you can se in "Download this repository" section.


# Installing

You must compress the install folder and copy to the destination machine to install:
```
scp /tmp/install.tar.gz root@destination_machine:/tmp/.
# or
cd /tmp
wget https://github.com/josem-amatriain/archlinux.install/archive/master.tar.gz
# or 
wget https://linkfox.io/instarchtargz

```

Using mc, you must uncompress master.atr.gz at /tmp
You must config etc/config.sh to fit your needs.

# Using scripts

The repository has two main scripts: ```install1.sh``` and ```install2.sh```
The first one, makes a basic install. The second one permits booting in the new fresh system and complete the installation.

In the destination machine, at the ```/tmp``` directory you must decompress the ```install.tar.gz```. You can use ```mc``` command. You must copy the ```/tmp/install``` folder from compressed file, and execute ```/tmp/install/install1.sh```

The last command in the script ```install1.sh``` is the execution of ```install2.sh```.
```
arch-chroot /mnt /bin/bash -c /tmp/install/install2.sh
```

# Customization
File "parts" (partitions file) must finish with a new line.

```
/home /dev/sda
/ /dev/sdb 
/var/lib/docker /dev/sdc
/usr/local /dev/sdd
```


