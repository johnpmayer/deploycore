#!/bin/bash

set -o nounset

# $1 name of new working copy directory

core_root=`pwd`

WDIR=$1
WCORE=$WDIR/core
TMP=$core_root/tmp

mkdir -p $TMP

if [ -d $WDIR ]
then
    
    echo "Package the filesystem located in $WCORE"
    set -x
    
    # pretty simple, didn't add and kernel modules or shared libraries
    (cd $WCORE; find | cpio -o -H newc | gzip -2 | tee ../core.gz > /dev/null)
    
    set +x
    
else
    
    echo "The directory $WDIR does not exist"
    
fi

echo "Cleaning up..."

rm -rf $TMP

echo "Finished packing $WDIR"
