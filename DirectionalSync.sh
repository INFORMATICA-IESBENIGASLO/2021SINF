#!/bin/bash
# 
# what is it for?
# Syncing directories unidirectional ORIGIN -> DESTINATION
# 
# By Pglez | Dlperezmartinez | Alejandrofan2
#
# ERROR CODES
# 0 > Success
# 1 > Success without changes
# 2 > Non parameter
# 3 > Directory not exists
# 10 > Unknown error
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## CHECKS ##
if [ $# -lt 2 ]
then
	echo "[!] Usage ./DirectionalSync.sh [ORIGIN] [DESTINATION]"
	exit 2
fi
if [[ ! -d "$1" ]]
then
    echo "$1 not exists on your filesystem."
    exit 3
fi
if [[ ! -d "$2" ]]
then
    echo "$2 not exists on your filesystem."
    exit 3
fi

## MAIN ##
originDir=$1
destinationDir=$2

clear
if [ $originDir -nt $destinationDir ]; then
    echo "Syncing..."
	rsync -avu $originDir $destinationDir
	echo "DONE"
	exit 0
else
	echo "Warning: $destinationDir has been changed later than $originDir"
	echo "Are you sure that you want to sync it? (y/N)"
	read answer
	if [ answer = "y" ] | [ answer = "yes" ] | [ answer = "Y" ] | [ answer = "YES" ] | [ answer = "Yes" ]; then
		echo "Syncing..."
		rsync -avu $originDir $destinationDir
		echo "DONE"
	elif [ answer = "n" ] | [ answer = "no" ] | [ answer = "N" ] | [ answer = "NO" ] | [ answer = "No" ]; then
         echo "Aborting..."
        exit 1
	else
        echo "You must put Y/Yes or N/No"
        echo "Aborting..."
        exit 1
	fi
	
exit 10

