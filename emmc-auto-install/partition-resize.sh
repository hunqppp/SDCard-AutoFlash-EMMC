#|---------------------------------------------------
#| Usage example: 
#|  -SD Card:  /bin/bash partition-resize.sh sdb 3
#|  -EMMC:     /bin/bash partition-resize.sh mmcblk0 p3
#|---------------------------------------------------

#!/bin/bash

DEVICE=$1
PARTNBR=$2

if [[ $# -eq 0 ]] ; then
    echo 'UNKNOWN DEVICE'
    exit 1
fi

if [[ $# -eq 1 ]] ; then
    echo 'UNKNOWN PARTITION NUMBER'
    exit 1
fi

echo "DEVICE: $DEVICE"
echo "PARTNBR: $PARTNBR"

start=$(cat /sys/block/$DEVICE/$DEVICE$PARTNBR/start)
end=$(($start + $(cat /sys/block/$DEVICE/$DEVICE$PARTNBR/size)))
newEnd=$(($(cat /sys/block/$DEVICE/size) - 8))

if [ "$newEnd" -gt "$end" ]
then
    echo "NO NEED TO RESIZE $DEVICE$PARTNBR"
    /usr/bin/sudo parted /dev/$DEVICE resizepart ${PARTNBR/[!0-9]} 100%
    /usr/bin/sudo resize2fs /dev/$DEVICE$PARTNBR
else
    echo "NO NEED TO RESIZE $DEVICE$PARTNBR"
fi
