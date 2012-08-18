#!/bin/sh

for port in `w3m -dump_source "http://www.freshports.org/search.php?stype=maintainer&method=match&query=lx%40&num=500&orderby=category&orderbyupdown=asc&search=Search"|grep mailto:lx|awk -F '%20' '{print $3}'|awk -F \" '{print $1}'`

do
	cd /usr/ports/${port}
	DISTDIR=/public/file/0/mirror make fetch
done

OTHERS="audio/musicpd"

for port in $OTHERS

do
        cd /usr/ports/${port}
        DISTDIR=/public/file/0/mirror make fetch
done
