#!/bin/bash

source usrInc.sh

SCRIPTRUN=flashEMMC.sh
INSTALLLOG=installLOG.txt

# Edit crontab job
(crontab -l ; echo "@reboot /bin/bash ${WORKPATH}/$SCRIPTRUN >> ${WORKPATH}/$INSTALLLOG 2>&1") | crontab -

# Restart system
$(SUPERUSRDO) reboot
