#|---------------------------------------------------
#| Usage example: 
#|  -SD Card:  /bin/bash partitionResize.sh sdb 1
#|  -EMMC:     /bin/bash partitionResize.sh mmcblk0 p1
#|---------------------------------------------------

#!/bin/bash

source usrInc.sh

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
    echo "NEED TO RESIZE $DEVICE$PARTNBR"
    echo $USRPASS | /usr/bin/sudo -S parted /dev/$DEVICE resizepart ${PARTNBR/[!0-9]} 100%
    echo $USRPASS | /usr/bin/sudo -S resize2fs /dev/$DEVICE$PARTNBR
else
    echo "NO NEED TO RESIZE $DEVICE$PARTNBR"
fi
