#!/bin/bash

LEDON=0
LEDOFF=1
LEDNUM=203 # IOG11

if [ ! -d /sys/class/gpio/gpio$LEDNUM ];
then
    echo $LEDNUM > /sys/class/gpio/export
    echo out > /sys/class/gpio/gpio$LEDNUM/direction
fi

for (( i=1; i<=2; i++ ))
do
    echo $LEDON > /sys/class/gpio/gpio$LEDNUM/value
    sleep 0.05
    echo $LEDOFF > /sys/class/gpio/gpio$LEDNUM/value
    sleep 0.05
done
