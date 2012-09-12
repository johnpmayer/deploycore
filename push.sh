#!/bin/bash

set -o nounset

# $1 name of new working copy directory

WDIR=$1
WZIP=$WDIR/core.gz
DEST=/var/lib/tftpboot/core.gz

if [ -d $WDIR ]
then
    
    echo "Push the archive located in $WDIR"
    set -x
    
    cp $WZIP $DEST
    
    set +x
    
else
    
    echo "The directory $WDIR does not exist"
    
fi

echo "Finished pushing $WDIR"
