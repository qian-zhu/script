#!/bin/bash
for dir in *
do
	if [ -d $dir ]; then
		echo -e "\e[1;31m In $dir make spotless... \e[0m"
		cd $dir;
		make spotless > /dev/null
		cd ..;
	fi
done
