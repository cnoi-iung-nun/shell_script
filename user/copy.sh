#!/bin/bash
# copy.sh send|recy FILE DIR

Usage() {
echo "Usage : copy.sh <send|recv> <src> <dest>"
echo "Example: copy.sh send file.txt /tmp"
}

if [ $# -eq 0 ]; then
    Usage
    exit 1
fi

ACTION=$1
SRC_FILE=$2
DST_DIR=$3
NET=192.168.10

SendFile() {
for i in $(seq 200 202)
    do
        ping -c 1 -W 2 $NET.$i >/dev/null 2>&1
        if [ $? -eq 0 ]; then
            echo "-------[  OK  ] $NET.$i ----------"
            scp "$SRC_FILE" "${NET}.${i}:${DST_DIR}"
            echo
        else
            echo "-------[ FAIL ] $NET.$i ----------"
            echo
        fi
    done
}

RecvFile() {
for i in $(seq 200 202)
    do
        ping -c 1 -W 2 $NET.$i >/dev/null 2>&1
        if [ $? -eq 0 ]; then
            echo "-------[  OK  ] $NET.$i ----------"
            HOSTNAME=$(ssh $NET.$i hostname)
            # scp 192.168.10.202:tmp/file1 tmp/file1.linux200
            DST_FILE=$(basename $SRC_FILE)
            # 파일 이름만 들어가게 끔 / SRC=/test/file1 basename $SRC -> file1
            scp "${NET}.${i}:$SRC_FILE" "${DST_DIR}/$DST_FILE.$HOSTNAME"
            echo
        else
            echo "-------[ FAIL ] $NET.$i ----------"
            echo
        fi
    done
}

case $ACTION in
    'send') SendFile ;;
    'recv') RecvFile ;;
    *) Usage ; exit 2 ;;
esac
