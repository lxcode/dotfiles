#!/bin/sh

for dir in `find . -type d`; do
	if [ -f $dir/.folder.gif ]; then
		giftopnm $dir/.folder.gif|pnmtopng > $dir/.folder.png&& rm $dir/.folder.gif
	elif [ -f $dir/.folder.jpg ]; then
		jpegtopnm $dir/.folder.jpg|pnmtopng > $dir/.folder.png&& rm $dir/.folder.jpg
	fi
done

