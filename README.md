# archlinux.install
Scripts for arch linux automtic installation.

# Install ARCHLINUX


## Steps
 
 * Create a bootable archlinux usb
 * To boot and set keyboard/console fonts
 * Set network manually
 * Patiotioning and setting UEFI boot
 * Initial minimal installation
 * Rebooting and complete installation using git
 
## Create a bootable archlinux usb
Download a Archlinux bootable iso image and write to a bootable USB device:

```
dd bs=4M if=/tmp/archlinux.iso of=/dev/sdh && sync
```

## BOOT


1. Set BIOS to boot using UEFI.

Press F12 to choose the boot device. We must to choose UEFI boot from USB

1. If the USB device is not detected the boot image says: Waiting 30 seconds...
You must to unplug and plug the usb device. The device will be recognized and you can continue.

1. If your screen is a modern one with very high resolution the console text will be unredable. You must change console font:

```
setfont iso01-12x22.psfu.gz
``` 
The fonts available are in /usr/share/fonts/local/
The /etc/vconsole file sets the console font in the installed system.


More fonts are available in the postinstallation process:

```
pacman -Sy terminus-font 
pacman -Ql terminus-font
setfont ter-v32n

# Setting the keyboard languaje : 
loadkeys es
```
[Loadkeys](https://wiki.archlinux.org/index.php/Linux_console/Keyboard_configuration#Loadkeys)


## Installing network manual mode

```
ip addr add 192.168.1.444/24 dev eth0
ip route show 
ip route add default via 192.168.1.1

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

You must download the repository with git. You must compress the install folder and copy to the destination machine:
```
scp /tmp/install.tar.gz root@192.168.1.123:/tmp/.
```

# Using scripts

The repository has two main scripts: ```install1.sh``` and ```install2.sh```
The first one, makes a basic install. The second one permits booting in the new fresh system and complete the installation.

In the destination machine, at the ```/tmp``` directory you must decompress the ```install.tar.gz```. Yo can use ```mc``` command. You must create the ```/tmp/install``` folder and execute ```/tmp/install/install1.sh```

When the script ```install1.sh``` finishes you are in the chroot environement and you must execute the ```install2.sh```.
```
/install/install2.sh
```


