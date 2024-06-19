#!/bin/bash

cat ./server.list | while read IP UNAME UPASS
do
	Cmd() {
		sleep 2 ; echo "$UNAME"
		sleep 1 ; echo "$UPASS"
		sleep 1 ; echo 'hostname'-+
		sleep 1 ; echo 'ls -l'
		sleep 1 ; echo 'exit'
	}
	Cmd | telnet $IP
done