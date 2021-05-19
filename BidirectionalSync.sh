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

## CHECKS ##
if [ $# -lt 2 ]
then
	echo "[!] Usage ./BidirectionalSync.sh [ORIGIN] [DESTINATION]"
	exit 2
fi
if [[ ! -d "$1" ]]
then
    echo -e "\n$1 not exists on your filesystem."
    echo "Aborting..."
    exit 3
fi
if [[ ! -d "$2" ]]
then
    echo -e "\n$2 not exists on your filesystem."
    echo "Aborting..."
    exit 3
fi

## MAIN ##
file1=$1
file1date=$(stat -c "%Y" $file1)

file2=$2
file2date=$(stat -c "%Y" $file2)

if [ $file1date -gt $file2date ]; then
	echo "The last changes have been detected in $file1, all data in $file2 will be overwritten"
	read -p "Are you sure?(y/N): " answer
	if [[ $answer == 'y' ]] || [[ $answer == 'yes' ]] || [[ $answer == 'Y' ]] || [[ $answer == 'YES' ]] || [[ $answer == 'Yes' ]]; then
        echo -e "Syncing...\n"
        rsync -va $file1/ $file2/
        echo -e "\nDONE!"
        exit 0
	elif [[ $answer == 'n' ]] || [[ $answer == 'no' ]] || [[ $answer == 'N' ]] || [[ $answer == 'NO' ]] || [[ $answer == 'No' ]]; then
        echo "Aborting..."
        exit 1
	else
        echo -e "\nYou must put Y/Yes or N/No"
        echo "Aborting..."
        exit 1
	fi

elif [ $file1date -lt $file2date ]; then
	echo "The last changes have been detected in $file2, all data in $file1 will be overwritten"
	read -p "Are you sure?(y/N): " answer
	if [[ $answer == 'y' ]] || [[ $answer == 'yes' ]] || [[ $answer == 'Y' ]] || [[ $answer == 'YES' ]] || [[ $answer == 'Yes' ]]; then
        echo -e "Syncing...\n"
        rsync -va $file2/ $file1/
        echo -e "\nDONE!"
        exit 0
	elif [[ $answer == 'n' ]] || [[ $answer == 'no' ]] || [[ $answer == 'N' ]] || [[ $answer == 'NO' ]] || [[ $answer == 'No' ]]; then
        echo -e "\nAborting..."
        exit 1
	else
        echo -e "\nYou must put Y/Yes or N/No"
        echo "Aborting..."
        exit 1
	fi
else
	echo -e "\nThe files in both folders are identical."
	echo "Aborting..."
    exit 1
fi
exit 10
