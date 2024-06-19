#!/bin/bash

PowerOFF() {
    sleep 2; echo "root"
    sleep 0.5; echo "1234"
    sleep 0.6; echo "poweroff"
}
NET="192.168.10"
SERVERLIST="$NET.201 $NET.202"
for i in $SERVERLIST
do
    PowerOFF | telnet "$i"

done

echo "Please Wait a Mins." 
sleep 15
# poweroff