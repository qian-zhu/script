#!/bin/bash
is_num=0
while [ $# -gt 0 ]
do
	para=$1
	if [ $is_num -eq 0 ]; then
		num=$(echo -n $para|sed 's/[0-9]//g') # delete number in parameter
		if [ ! -n "$num" ]; then
			num=$para
			is_num=1;
		fi	
	fi
	
	case $para in
	-m)
		if [ ! -n "$2" ]; then
			message="NULL"
		else
			message=$(echo "$2"|sed 's/\ /\\ /g')
		fi
		break;
	;;
	esac
	shift

done

if [ $is_num -eq 0 ]; then #if parameter is null(only contain number)
    target=sw_octeon5500-mc-stdeb;
	num=5500;
else
    target=sw_octeon$num-mc-stdeb;
fi


#echo "message is : $message"

#if [ ! -n "$message" ]; then
#	echo -e "\e[1;31m Please input some infomation of firmware : -m message\e[0m";
#	exit -1;
#fi


version=$(pwd|sed 's/^.*WorkSet\///g'|sed 's/\/.*//g')

if [ -n "$version" ]; then
    workpath=$(pwd|sed "s/$version.*$/$version/g");
    targetpath=$workpath/m2/target/oct_mips64/$target
    echo -e "\e[1;31m Building workpath is : $workpath \e[0m";
    echo -e "\e[1;32m Target is : $target \e[0m";
	echo -e "\e[1;32m message is : $message \e[0m";

    cd $workpath;make -j10 $target;
	if [ "$?" -eq "0" ]; then
		mv $targetpath/firmware.bin.sig $targetpath/"$message".firmware.bin.sig;
		mv $targetpath/filesys.dat.eng /home/zq/tftpboot/;
		mv $targetpath/packet-engine.eng /home/zq/tftpboot/;
		mv $targetpath/vxWorks.st.eng /home/zq/tftpboot/;
		echo -e "\e[1;32m new firmware name is : $message.firmware.bin.sig \e[0m";
		echo -e "\e[1;32m $(date) \e[0m";
	else
		echo -e "\e[1;31m Build $message.firmware.bin.sig failed!\e[0m";
		exit -1
	fi
else
    echo "workpath is null";
fi




























