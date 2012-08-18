#!/bin/sh

# check a given page for links that result in 404s.

USAGE="usage: $0 http://myurl.com/apage.html"

if [ ! "$#" -eq 1 ]; then
	echo $USAGE
	exit 1
fi

for link in `curl -s $1|grep href|sed 's/.*\="//g'|sed 's/".*//g'` 

do

	echo "checking $link..."
	curl -s --fail $link >>/dev/null || echo $link is broken.

done
