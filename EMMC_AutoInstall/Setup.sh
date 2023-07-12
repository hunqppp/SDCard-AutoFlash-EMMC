#!/bin/bash

WORKPATH=/home/pi/EMMC_AutoInstall
SCRIPTRUN=EMMC_Install.sh
INSTALLLOG=installLOG.txt

# Edit crontab job
(crontab -l ; echo "@reboot /bin/bash ${WORKPATH}/$SCRIPTRUN >> ${WORKPATH}/$INSTALLLOG 2>&1") | crontab -
# Restart system
/usr/bin/sudo reboot
