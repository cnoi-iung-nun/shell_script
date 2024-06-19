#!/bin/bash

## 3대의 서버에 모두 전송하는 쉘 스크립트
SERVERLIST=.
/server.txt

for i in $(cat $SERVERLIST)
do
ftp -n "$i" 21 << EOF
user root 1234
cd /tmp
lcd /test
bin
hash
prompt
mput testfile.txt
quit
EOF
done