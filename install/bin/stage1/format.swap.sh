
PARTICION="$1"
FS="$2"
TYPE="$3" 
LABEL="$4"

#mkfs.$FS -F32 -n $LABEL $DEVICE
mkswap ${PARTICION} -L $LABEL
swapon -a



