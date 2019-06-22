# Instalación

1. Crear un usb de arranque
1. Arrancar desde usb
1. Primeros pasos
1. Customizing the installation process

## Crear USB

### Get ISO image from archlinux web: 

To create a bootable archlinux usb
[Download a Archlinux bootable iso](https://www.archlinux.org/download/) image and write to a bootable USB device with this commands:

### Write image to disk

```
dd bs=4M if=/tmp/archlinux.iso of=/dev/sdh && sync
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

When you are done, you can run the install process:

```bash
/tmp/install/bin/stage1/install.sh 
```

Be sure you set up  de DEBUG variable to empty: DEBUG="", If DEBUG is set at DEBUG=debug all standard output is sent to a debug file at /tmp/debug.* It can be util to debug scripts.


