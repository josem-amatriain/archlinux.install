# Installation

1. Make a bootable USB
1. Boot from USB
1. First steps
1. Customizing the installation process

## Make bootable USB

### Get ISO image from archlinux web: 

To create a bootable archlinux usb
[Download a Archlinux bootable iso](https://www.archlinux.org/download/) image and write to a bootable USB device with this commands:

### Write image to disk

```
# dd bs=4M if=/tmp/archlinux.iso of=/dev/sdh && sync
dd bs=4M if=/path/archlinux.iso of=/dev/sdX status=progress && sync
```

## First boot

Plug the created usb in the usb port of the new computer to be installed.

You must boot the new computer using UEFI mode. You must choose the F2/Del key to enter BIOS and configure UEFI boot or F11 key to choose UEFI partition of the USB device.

Now you have booted from USB your new computer and you have a prompt:

```bash 
root@archiso ~ #
```

### Firts commands

The first command must be loadkeys. You can choose your correct layout for the keyboard:

```bash
loadkeys es
loadkeys fr
loadkeys uk
```

Theese are for spanish, french and british english. More info here: 
[Loadkeys](https://wiki.archlinux.org/index.php/Linux_console/Keyboard_configuration#Loadkeys)

Now you can heck if UEFI is OK:

```
ls /sys/firmware/efi/efivars
```

##  First scripts

### Your network is not configured by dhcp

If your new computer have the network interface configured you can skip this section.

If you d'ont have network connection in the computer booted from USB, you can copy the requiered files to a second USB and plug it to the new computer.
This script can help you to config the network:

[network.manual.install.sh](https://raw.githubusercontent.com/josem-amatriain/archlinux.install/master/network.manual.install.sh)

This method only works for wired networks, for wireless networks you need to run wifi-menu. This is a sript from arclinux installation that will config your wireless device. You must know the accesspoint name and the credentials.

### Your network is configured by dhcp or by manual method

Now you must download at your desktop computer the initial scripts and
copy it to a second USB and plug it to the new computer.

If your network is working, you must get the ```init.sh``` script. It can:
1. Get the rest of the installation scripts.
1. Store caché packages to speed-up the installation process.
1. Start sshd and set a default password, to access from a remote computer.

The ```init.sh``` script:
[init.sh](https://raw.githubusercontent.com/josem-amatriain/archlinux.install/master/init.sh)

```bash
wget https://raw.githubusercontent.com/josem-amatriain/archlinux.install/master/init.sh -O /tmp/init.sh
chmod a+x /tmp/init.sh
```

This script creates a structure of folders at 

```bash 
/tmp/archlinux.install-master
/tmp/install
```

# Customizing

Change basic settings, and partition layout at ```/tmp/install/config/*```
The file config.sh sets the bash variables used for install proccess.

## Partititons

The disks are partitioned using GPT. All disks set at variable "DISKS" (of file config.sh) are initialized and erased.
The file config.parts sets the partitions layout to be created: theirs filetype, disks, positions, purpouse (boot, root, other), mount points, label, beginning and end. The beginning and end  of the partitions is set as a size or a percent:
 * A partition begining at the first sector is set as 0%. 
 * If the partition fills the entire disk: 0% 100%.
 * A partition from 100M to end of disk: 100M 100%.
 * A disk of two partitions, the first one 1GB at the bedinning, the second one the rest of the disk.
  * fat      /dev/sda 1 boot  /boot LABEL1  0% 1GB
  * btrfs    /dev/sda 2 root  /     LABEL2  1GB 100%
  

When you are done, you can run the install process:

```bash
/tmp/install/bin/stage1/000.install.sh 
```

Be sure you set up  de DEBUG variable to empty: DEBUG="", If DEBUG is set at DEBUG=debug all standard output is sent to debug files at /tmp/debug.* It can be usefull to debug scripts.


# Finishing

Now you can use ansible to finish the installation.
There are a lot of projects at github: 

* https://github.com/dharmab/ansible-archlinux
* https://github.com/AlexandreCarlton/ansible-archlinux
* https://github.com/id101010/ansible-archlinux
* Módulo aur: https://github.com/kewlfft/ansible-aur
* https://github.com/finchd/archlinux-install
* https://github.com/tyjak/ansible-archlinux
* https://github.com/DasFranck/Archsible
* https://github.com/sudoforge/archer
* En portatiles DELL XPS13 https://github.com/novln/Kiss-my-Arch
* https://github.com/novln/Kiss-my-Arch/tree/master/bootstrap/xps13-9360-install
* https://github.com/burakkose/dotfiles
* https://github.com/clux/provision/blob/ansible/
* Instalación y chroot: https://github.com/clux/provision/tree/ansible/archboot
* IPTABLES: https://github.com/novln/ansible-playbook/blob/master/ovh.yml



### Others 

* Hihg resolution screens: https://wiki.archlinux.org/index.php/HiDPI
* https://wiki.archlinux.org/index.php/NetworkManager
* https://wiki.archlinux.org/index.php/Dell_XPS_13_(9343)

