#!/bin/bash

WORKPATH=/home/pi/emmc-auto-install
SCRIPTRUN=emmc-install.sh
INSTALLLOG=install-log.txt

# Edit crontab job
(crontab -l ; echo "@reboot /bin/bash ${WORKPATH}/$SCRIPTRUN >> ${WORKPATH}/$INSTALLLOG 2>&1") | crontab -
# Restart system
/usr/bin/sudo reboot
