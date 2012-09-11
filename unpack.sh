#!/bin/bash

set -o nounset

# $1 name of new working copy directory

core_root=`pwd`

WDIR=$1
WCORE=$WDIR/core
TMP=$core_root/tmp
MNT=$TMP/mnt

orig=static/PXE-nix-getsetup.iso

mkdir -p $TMP
mkdir -p $MNT

if [ -d $WDIR ]
then
    
    echo "Won't overwrite existing $WDIR"
    
else
    
    echo "Creating fresh copy of core linux in $WDIR"

    set -x
    
    # Get the all of the files out of the ISO
    mount $orig $MNT -o loop,ro
    cp -a $MNT/boot $TMP/boot
    umount $MNT
    
    # set up the working directory
    mkdir -p $WDIR
    mkdir -p $WCORE
    
    # regular copy the boot folder and the kernel
    cp $TMP/boot/vmlinuz $WDIR/
    cp -r $TMP/boot/isolinux $WDIR
    
    # uncompress the filesystem
    (cd $WCORE; zcat $TMP/boot/core.gz | cpio -i -H newc -d)
    
    set +x
    
fi

echo "Cleaning up..."

rm -rf $TMP

echo "Finished preparing fresh $WDIR"
