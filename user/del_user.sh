#!/bin/bash

USERLIST=/script/user.list
cat $USERLIST | while read UNAME UPASS
do
    userdel -r $UNAME  > /dev/null 2>&1
    [ $? -eq 0 ] && echo "[ OK ] $UNAME deleted."
done
