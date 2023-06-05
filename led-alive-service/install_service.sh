#!/bin/bash

SERVICE_NAME="led-alive.service"

/usr/bin/sudo cp alive-script.sh /usr/local/bin
/usr/bin/sudo chmod +x /usr/local/bin/alive-script.sh
/usr/bin/sudo cp led-alive.service /etc/systemd/system

# Check the service is active or not
/usr/bin/sudo systemctl daemon-reload
if systemctl is-active --quiet $SERVICE_NAME ; then
    /usr/bin/sudo systemctl restart $SERVICE_NAME
else
    /usr/bin/sudo systemctl enable $SERVICE_NAME
    /usr/bin/sudo systemctl start $SERVICE_NAME
fi
