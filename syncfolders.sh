#!/bin/bash
# Sync the newer dir over the other one

Dir1=$1
Dir2=$2

if [ $Dir1 -nt $Dir2 ]; then
	rsync -auv $Dir1 $Dir2 
elif [ $Dir2 -nt $Dir1 ]; then
        rsync -auv $Dir2 $Dir1
else 
	echo "no changes between dirs"
fi

exit 0

