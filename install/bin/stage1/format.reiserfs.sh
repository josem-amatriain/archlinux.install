
DEVICE="$1"
FS="$2"
TYPE="$3" 
LABEL="$4"

mkfs.$FS -l $LABEL $DEVICE


