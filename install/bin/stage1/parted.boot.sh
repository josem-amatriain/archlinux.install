#!/bin/bash -x

parted /dev/sda mkpart myName fat16 0% 225M
parted /dev/sda set 1 esp on


# Parted syntax:
#	FS-TYPE is one of: btrfs, nilfs2, ext4, ext3, ext2, fat32, fat16, hfsx, hfs+, hfs, jfs, swsusp, linux-swap(v1), linux-swap(v0), ntfs, reiserfs, hp-ufs, sun-ufs, xfs,
#        apfs2, apfs1, asfs, amufs5, amufs4, amufs3, amufs2, amufs1, amufs0, amufs, affs7, affs6, affs5, affs4, affs3, affs2, affs1, affs0, linux-swap, linux-swap(new),
#        linux-swap(old)
#        START and END are disk locations, such as 4GB or 10%.  Negative values count from the end of the disk.  For example, -1s specifies exactly the last sector.
