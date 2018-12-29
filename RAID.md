# Config RAID5

## Cleaning
mdadm --misc --zero-superblock /dev/sdX
mdadm --misc --zero-superblock /dev/sdX1

## Create partititons
(Create gpt table: mklabel gpt) Create partitions (using gdisk) RAID partition type= FD00 
``` 
parted /dev/sda mklabel gpt 
gdisk /dev/sda

``` 

## Create RAID5
``` 
mdadm --create --verbose --level=5 --metadata=1.2 --chunk=256 --raid-devices=3 /dev/md0 /dev/sdb1 /dev/sdc1 /dev/sdd1 --spare-devices=1 /dev/sda1 
mdadm --create --verbose --level=5 --metadata=1.2 --chunk=256 --raid-devices=4 /dev/md0 /dev/sda1 /dev/sdb1 /dev/sdc1 /dev/sdd1
```

The first one, it creates a raid5 with 1 spare disk (Two disks failure tolerance); the second one, a raid5 without spare disk (one disk failure tolerance).

## FORMAT

Example formatting to ext4 with the correct stripe width and stride:
    Hypothetical RAID5 array is composed of 4 physical disks; 3 data discs and 1 parity disc.
    Chunk size is 512 KiB.
    Block size is 4 KiB.

stride = chunk size / block size. In this example, the math is 512/4 so the stride = 128.
stripe width = # of physical data disks * stride. In this example, the math is 3*128 so the stripe width = 384.
```
mkfs.ext4 -v -L myarray -m 0.01 -b 4096 -E stride=128,stripe-width=384 /dev/md0
```


## Mount
mount /dev/md0 /mnt 

