#!/bin/bash

set -o nounset

# $1 name of source directory
# $2 name of new working copy directory

core_root=`pwd`

SRC=$1
DST=$2

if [ -d $DST ]; then
    
    echo "Won't overwrite existing destination $DST"

elif [ -d $SRC ]; then

    echo "Cloning $SRC as $DST"
    
    set -x
    
    cp -a $SRC $DST
    
    set +x
    
else
    
    echo "The source $SRC does not exist"
    
fi

