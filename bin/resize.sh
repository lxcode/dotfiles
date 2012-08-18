#!/bin/sh

USAGE="usage: $0 directory scalefactor"

if [ ! "$#" -eq 2 ]; then
        echo $USAGE
        exit 1
fi

SRCDIR=$1
FACTOR=$2

for file in `cd $SRCDIR; ls *.jpg`
do
	jpegtopnm $SRCDIR/$file | \
	pnmscale $FACTOR | \
	pnmtojpeg > $file
done

for file in `cd $SRCDIR; ls *.png`
do
	pngtopnm $SRCDIR/$file | \
	pnmscale $FACTOR | \
	pnmtopng > $file
done
