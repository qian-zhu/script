#!/bin/bash
# A script to merge files in different directories.
#	-ps : directory of source file
#	-pd : directory of dest file
#	-f	: a text contain name of files to be merged
# For example : 
#	echo "firmware/fw/HA/haStatus.c" > file_list.txt
#	merge-tool.sh -pd release_6.1.1.0_ipv6 -ps RFE_fwdev6 -f file_list.txt
#
# Dependence: 
#	1.meld
# Author : Amos Zhu(qzhu@sonicwall.com)
while [ $# -gt 0 ]
do
	para=$1
	case $para in
	-ps)
		prefixs=$2
		echo "prefixs is :$prefixs"
	;;

	-pd)
		prefixd=$2
		echo "prefixd is :$prefixd"
	;;
	-f) 
		if [ -f "$2" ]; then
			file_list=$2
			echo "file list is :$file_list";
		else
			echo "file list $2 doesn't exist!"
		fi
	;;
	esac
	shift
done

if [ -f $file_list ]; then
	while read line
	do
		echo -e "\e[1;31m Begin to merge $prefixd/$line and $prefixs/$line\e[0m";
		if [ ! -w "$prefixd/$line" ]; then
			error=$(p4 edit "$prefixd/$line" 2>&1);
			if [[ "$error" == *"not on client"* ]]; then
				sudo chmod +w "$prefixd/$line";
			fi
		fi


		if [ ! -w "$prefixs/$line" ]; then
			error=$(p4 edit "$prefixs/$line" 2>&1);
			if [[ "$error" == *"not on client"* ]]; then
				sudo chmod +w "$prefixs/$line";
			fi
		fi
		meld $prefixd/$line $prefixs/$line
		
	done < $file_list
fi
