#!/bin/sh

/usr/local/libexec/post.fm "$@" &
#python $HOME/.cmus/cmus-updatepidgin.py "$@" > /dev/null 2>&1 &

ICON=`dirname $4`/.folder.png
NEWICON="$HOME/.cmus/now-playing.png"

while [ "$#" -ge 2 ] ; do
  ### $_key='val'
  eval _$1='$2'
  shift
  shift
done


if [ "$_status" = 'playing' ] ; then
	/usr/local/bin/cmus-remote --raw win-sel-cur&
#	sleep 2 && echo "1 setstatustext" "Now Playing: $_artist - $_album - $_title ($_date)" |awesome-client&
#	pngtopnm $ICON |pamscale -pixels 9216|pnmtopng > $NEWICON;  notify-send -i $NEWICON "Now Playing:" "$_artist - $_album - $_title ($_date)"
fi
