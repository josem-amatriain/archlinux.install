# archlinux.install
Scripts for arch linux automtic installation.

# Install ARCHLINUX


## Steps
 
 * Crear un usb arrancable
 * Arrancar y poner teclado es y fuentes
 * Poner red manualmente
 * Particionar y poner arranque uefi
 * Instalación inicial
 * Reiniciar y completar install usando git
 


## Crear un usb arrancable (3.0) con una imagen iso de arch

```
dd bs=4M if=/tmp/archlinux.iso of=/dev/sdh && sync
```

## Arrancar

Pulsar F12 para elegir el dispositivo de arranque 

Elegir arranque uefi desde usb: UEFI: SanDisk, Partition 1.



1.- Al arrancar el usb usar uefi y elegir arch...
2.- Si no encuentra el usb. Solución: Cuando dice que waiting 30segundos sacar el usb y volverlo a meter. Así lo reconoce y arranca ok

3.- Si no se ve el texto de consola: setfont iso01-12x22.psfu.gz
/usr/share/fonts/local/

Mejor sería, después de instalar la red, 
pacman -Sy terminus-font 
pacman -Ql terminus-font
setfont ter-v32



## Instalar RED modo manual

```

ip addr add 192.168.1.444/24 dev eth0
ip route show 
ip route add default via 192.168.1.1

echo -en "\nnameserver 8.8.4.4\n" >> /etc/resolv.conf

ping archlinux.org


```

A partir de ahora puedo usar scripts remotos preparados.

```
timedatectl set-ntp true
systemctl start sshd 
passwd 123456
123456
```

PAra acceso remoto

