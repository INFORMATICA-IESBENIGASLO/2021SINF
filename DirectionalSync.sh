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
    echo -e "$1 not exists on your filesystem."
    echo "Aborting..."
    exit 3
fi
if [[ ! -d "$2" ]]
then
    echo -e "$2 not exists on your filesystem."
    echo "Aborting..."
    exit 3
fi

## MAIN ##
originDir=$1
destinationDir=$2

clear
if [ $originDir -nt $destinationDir ]; then
    echo -e "Syncing...\n"
	rsync -avu $originDir/ $destinationDir/
	echo -e "\nDONE!"
	exit 0
else
	echo "Warning: $destinationDir has been changed later than $originDir."
	read -p "Are you sure that you want to sync it? (y/N): " answer
	if [[ $answer == 'y' ]] || [[ $answer == 'yes' ]] || [[ $answer == 'Y' ]] || [[ $answer == 'YES' ]] || [[ $answer == 'Yes' ]]; then
		echo -e "Syncing...\n" 
		rsync -avu $originDir/ $destinationDir/
		echo -e "\nDONE!"
	elif [[ $answer == 'n' ]] || [[ $answer == 'no' ]] || [[ $answer == 'N' ]] || [[ $answer == 'NO' ]] || [[ $answer == 'No' ]]; then
         echo -e "\nAborting..."
        exit 1
	else
        echo  -e"\nYou must put Y/Yes or N/No"
        echo "Aborting..."
        exit 1
	fi
fi
exit 10
