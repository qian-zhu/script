#!/bin/bash
# If the last argument is a directory, this script 
#	1. Map local directory to depot on p4 server
#	2. execute p4 command
# Else
#	execute p4 command directly
#
# Author: qzhu@sonicwall.com

#  ( "$@" )  : convert paramters to an array
param=( "$@" )

for i in ${!param[*]}
do
	if [ -d ${param[$i]} ]; then
		param[$i]=$(echo $(pwd)/${param[$i]}... | sed s/^.*Firmware/\\/\\/depot\\/Firmware/)
	fi
done

echo "p4" ${param[*]}
/home/zq/bin/p4v/bin/p4 ${param[*]}

