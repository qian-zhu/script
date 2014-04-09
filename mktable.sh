#!/bin/bash
# This script print a html table to a temporary fille /tmp/mktable
# You can use it in vim by "!mktable 3 4"
#
# $1 : row number of table
# $2 : column number of table

if [ -n "$1" ] && [ -n "$2" ]; then
	echo "<table>" > /tmp/mktable
	for ((i=0;i<$1;i++)); do
		echo -e "\t<tr>" >> /tmp/mktable
			for ((j=0;j<$2;j++)); do
				echo -e -n "\t\t<td>  </td>">> /tmp/mktable;
			done
			echo -e -n "\n" >> /tmp/mktable
		echo -e -n "\t</tr>\n" >> /tmp/mktable
	done
	echo "</table>" >> /tmp/mktable
	cat /tmp/mktable | xsel -b
else
	echo "Please input row and column"
	exit -1;
fi
