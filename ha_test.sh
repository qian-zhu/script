#!/bin/bash
# Make sure eth0 has been disabled(directly connected to server) 
if [ $(ifconfig eth0 | grep "inet addr" | wc -l) -gt 0 ]; then
	/usr/bin/nmcli dev disconnect iface eth0
	if [ $? -eq 0 ]; then
		echo "Disconnected eth0 succefully!";
	else
		echo "Fail to disconnected eth0,please diconnect it manually !";
		return -1;
	fi
fi
echo -e "open 10.103.10.229\nlogin zq 111111\ncd test\nget ubuntu-9.10-dvd-i386.iso" > /tmp/tmp.ha_test.txt;
lftp -f /tmp/tmp.ha_test.txt

