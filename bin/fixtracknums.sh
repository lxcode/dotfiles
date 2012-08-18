#!/bin/sh

for file in `find . -name "*.ogg"`
do

# does it already have a number?
testtrack=`vorbiscomment $file|grep -o TRACKNUMBER`
# is the first part of the filename a number?
testnum=`basename $file|cut -c 1,2|grep -x "[0-9][0-9]"`

if test -n "$testtrack"
then
        true
elif test -z "$testnum"
then
	true
else
        track=`basename $file|awk -F_ '{print $1}'`
        vorbiscomment -a -t "TRACKNUMBER=$track" $file
fi
done

