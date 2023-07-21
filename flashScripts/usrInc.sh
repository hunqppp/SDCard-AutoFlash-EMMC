#!/bin/bash

USRNAME="device"
USRPASS="Xk4S/n"
IMG_TARGET=$(ls | grep .img)
PARTITION_RESIZE=p1
SHELL=/bin/bash
WORKPATH="/home/${USRNAME}/flashScripts"

### echo $USRPASS | /usr/bin/sudo -S command -> Auto fill password when running "sudo"