#!/bin/bash
# 
# what is it for?
# Synchronize directories bi-directionally using rsync
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
# # # # # # # # # # # # # # # # # # # # # # # # # # # # #
clear

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
file1 = $1
file1date = $(stat -c "%Y" $file1)

file2 = $2
file2date = $(stat -c "%Y" $file2)

if [ $file1date -gt $file2date ]; then
    $answer = N
	echo "The last changes have been detected in $file1, all data in $file2 will be overwritten"
	echo "Are you sure(y/N)"
	read answer
	if [ Answer = "y" ] | [ Answer = "yes" ] | [ Answer = "Y" ] | [ Answer = "YES" ] | [ Answer = "Yes" ] ; then
        echo "Syncing..."
        rsync -a $file1/ $file2/
        echo "DONE"
        exit 0
	elif [ Answer = "n" ] | [ Answer = "no" ] | [ Answer = "N" ] | [ Answer = "NO" ] | [ Answer = "No" ]; then
        echo "Aborting..."
        exit 1
	else
        echo "You must put Y/Yes or N/No"
        echo "Aborting..."
        exit 1
	fi

elif [ $file1date -lt $file2date ]; then
    $answer = N
	echo "The last changes have been detected in $file2, all data in $file1 will be overwritten"
	echo "Are you sure(y/N)"
	read answer
	if [ Answer = "y" ] | [ Answer = "yes" ] | [ Answer = "Y" ] | [ Answer = "YES" ] | [ Answer = "Yes" ] ; then
        echo "Syncing..."
        rsync -a $file2/ $file1/
        echo "DONE"
        exit 0
	elif [ Answer = "n" ] | [ Answer = "no" ] | [ Answer = "N" ] | [ Answer = "NO" ] | [ Answer = "No" ]; then
        echo "Aborting..."
        exit 1
	else
        echo "You must put Y/Yes or N/No"
        echo "Aborting..."
        exit 1
	fi
else
	echo "The files in both folders are identical."
	echo "Aborting..."
    exit 1
fi
exit 10
