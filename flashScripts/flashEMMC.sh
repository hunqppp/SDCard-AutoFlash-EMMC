#=============================================================
# C R O N T A B                         [ CLI: crontab --help]
#=============================================================
# 1. Crontab format
#
#   * * * * * Commands to be executed
#   | | | | |_____ Day of week (0-6) (Sunday = 0)
#   | | | |_______ Month (1-12)
#   | | |_________ Day of month (1-31)
#   | |___________ Hour (0-24)
#   |_____________ Minute (0-59)
#
# 2. Cron special keywords
#   Keyword    Equivalent       Explanation
#   @yearly    0 0 1 1 *        To schedule a job for first minute of every year using @yearly (at 00:00 on 1st of every month)
#   @daily     0 0 * * *        To schedule a Cron job beginning of every month using @monthly (at 00:00 on Jan 1st for every year)
#   @hourly    0 * * * *        To schedule a background job every day using @daily (at 00:00 on every day)
#   @reboot    Run at startup   To execute a linux command after every reboot using @reboot#
#=============================================================

#=============================================================
# Author:   HungPNQ
# Date:     29/05/2023
# Title:    Auto flash (XXX.img) from SD Card to EMMC on NanoPi-NEO
# Log: 
#           29/05/2023: 
#           - Create file
#           - Installation:
#               + crontab -e
#               + Command: @reboot /bin/bash /home/pi/EMMC_AutoInstall/flash-run.sh > /home/pi/EMMC_AutoInstall/log.txt 2>&1
#           - Monitoring realtime:
#               + tail -f installLOG.txt
#           20/7/2023:
#           - Extend user macro
#=============================================================

#!/bin/bash

### User include
source usrInc.sh

### Local variables
DISK_COUNT=
EMMC="mmcblk0"
FLASHER=0

### Get current time date
uptime=$(date +"%Y-%m-%d %H:%M:%S")

### User function
function uptimeFunction() {
    echo "UPTIME: ${uptime}"
}

### TODO
uptimeFunction

### Get the number of disks on the system
DISK_COUNT=$(lsblk -no TYPE | grep "disk" | wc -l)
echo "SYSTEM DISKS: $DISK_COUNT"

### Check system boot device
DISKS=$(lsblk -ndo NAME)
LIST_DISKS=($DISKS)

for disk in "${LIST_DISKS[@]}"; do
    if [[ $disk == "mmcblk1" ]];
    then
        EMMC=$disk
    fi
done

if [[ "$EMMC" == "mmcblk1" ]];
then
    echo "BOOT FROM SD Card"
    FLASHER=1
else
    echo "BOOT FROM EMMC"
fi

if [[ $FLASHER == 1 ]];
then
    ### Check is .img is exist or not
    if [ -f "${WORKPATH}/${IMG_TARGET}" ];
    then
        echo $USRPASS | /usr/bin/sudo -S dd if=$WORKPATH/$IMG_TARGET of=/dev/$EMMC bs=4M conv=fsync status=progress
        sync
        echo $USRPASS | /usr/bin/sudo -S $SHELL $WORKPATH/partitionResize.sh $EMMC $PARTITION_RESIZE
        echo $USRPASS | /usr/bin/sudo -S poweroff
    else
        echo "$WORKPATH/$IMG_TARGET DOES NOT EXIST -> FLASH (.img) TO EMMC FAILED"
    fi
fi
