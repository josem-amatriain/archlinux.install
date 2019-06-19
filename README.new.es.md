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

Plug the created usb in the usb port of the computer to be installed.

You must boot the computer using UEFI mode. You must choose the F2/Del key to enter BIOS and configure UEFI boot or F11 key to choose UEFI partition of the USB device.

Now you have booted from USB and you have a prompt:

```bash 
root@archiso ~ #
```

### Firts commands

The first command must be loadkeys. You can choose your correct layout:

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

You must get the ```initial.sh``` script. It can:
1. Install manually the network interface.
1. Get the rest of the installation scripts.
1. Store caché packages to speed-up the installation process.
1. Start sshd and set a default password, to access from a remote computer.

If you have a network connection you can download the ```initial.sh``` script. If yo d'ont, you can copy the requiered files to a seconf USB and plug it to the computer.
LINK TO initial.sh



### Get installation sripts

```bash 
wget https://linkfox.io/instarchtargz -O branch.tar.gz
```



