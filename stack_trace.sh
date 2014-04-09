#!/bin/bash
if [ -s "$1" ]; then	#-s : file exist and size > 0
	address=$(xsel -b);
	echo -e "\e[1;31m$address\e[0m";
#	result=$(echo $address | xargs mipsisa64-octeon-elf-addr2line -f -e "$1");
	result=$(echo $address | xargs addr2line -f -e "$1");
	echo -e $result | tr ' ' '\n' | sed -r '/\:[0-9]+/a \\r'
fi
