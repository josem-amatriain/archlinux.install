


# pacman -S nfs-utils
mkdir -o /mnt/misCosas



mount -t nfs -o "nfsvers=3,rw" 192.168.0.1:/nfs/misCosas /mnt/misCosas


