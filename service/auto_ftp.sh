#!/bin/bash

ftp -n 192.168.10.201 21 << EOF
user root 1234
cd /tmp
lcd /test
bin
hash
prompt
mput testfile.txt
quit
EOF