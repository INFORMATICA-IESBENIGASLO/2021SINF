#!/bin/bash
# 
# what is it for?
# Syncing directories unidirectional ORIGIN -> DESTINATION
# 
# By Pglez | Dlperezmartinez | Alejandrofan2
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
clear

## CHECKS ##
if [ $# -lt 2 ]
then
	echo "[!] Usage ./DirectionalSync.sh [ORIGIN] [DESTINATION]"
	exit 1
fi

## MAIN ##
originDir=$1
destinationDir=$2

if [ $originDir -nt $destinationDir ]; then
	rsync -avu $originDir $destinationDir
else
	Warning: $destinationDir has been changed later than $originDir
	echo "Are you sure that you want to sync it? (y/n)"
	read Answer
	if [ Answer = "y" ]; then
		rsync -avu $originDir $destinationDir
	fi
fi
	
exit 0

