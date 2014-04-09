#!/bin/bash
#
# I think I can write a script to wrap common functions in octopress.
# Then I can update my blog in any directory :-)
#
if [ -n "$1" ] && [ -n "$BLOG_DIR" ]; 
then
	echo "$BLOG_DIR";
	cd $BLOG_DIR;
	postname=$(rake new_post["$1"] | sed 's/^.*post:\ //g');
	vim $postname; 
	cd -;
elif [  ! -n "$1" ]; then
	echo "Please input post name"
	exit -1;
else
	echo "Please set environment variable: BLOG_DIR";
	exit -1;
fi

