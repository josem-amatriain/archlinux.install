
DEVICE="$1"
FS="$2"
TYPE="$3" 
LABEL="$4"

#mkfs.$FS -F32 -n $LABEL $DEVICE
mkswap ${DEVICE} -L $LABEL
swapon -a



