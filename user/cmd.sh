#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 <CMD>"
    exit 1
fi
CMD="$*"

NET=192.168.10
SERVERLIST="$NET.200 $NET.201 $NET.202"

for i in $SERVERLIST
do 
    ping -c 1 -W 2 $i >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "-------[  OK  ] $i ----------"
        ssh $i "$CMD"
        echo
    else
        echo "-------[ FAIL ] $i ----------"
        echo
    fi
done