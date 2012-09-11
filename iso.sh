#!/bin/bash

set -o nounset

# $1 name of new working copy directory

core_root=`pwd`

WDIR=$1
WCORE=$WDIR/core
TMP=$core_root/tmp

src_kernel=$WDIR/vmlinuz
src_isolinux=$WDIR/isolinux
src_initrd=$WDIR/core.gz

isodir=$TMP/iso
bootdir=$isodir/boot

mkdir -p $TMP
mkdir -p $isodir
mkdir -p $bootdir

outfile=PXE-nix-$WDIR.iso

if [ -d $WDIR ]; then
    
    echo "Creating a new iso '$outfile' from $WDIR"

    set -x
    
    cp -r $src_kernel $src_isolinux $src_initrd $bootdir/
    
    (cd $TMP; mkisofs -l -J -r -R -V PXE-nix-$WDIR -no-emul-boot -boot-load-size 4 \
        -boot-info-table -b boot/isolinux/isolinux.bin \
        -c boot/isolinux/boot.cat -o ../$outfile iso)
    
    set +x

else
    
    echo "The directory $WDIR does not exist"
    
fi

echo "Cleaning up..."

rm -rf $TMP

echo "Finished preparing $outfile"
