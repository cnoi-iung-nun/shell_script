#!/bin/bash

cat user.list | while read UNAME UPASS

do
	useradd $UNAME >/dev/null 2>&1
	[ $? -eq 0 ] && echo " [  OK  ] $UNAME added."

	echo $UPASS | passwd --stdin $UNAME > /dev/null 2>&1
	[ $? -eq 0 ] && echo " [  OK  ] $UNAME setted."
done  