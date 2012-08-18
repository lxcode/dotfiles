#!/bin/sh

cat "$@" |sed -n -e '/^[xX]-[fF]ace/,/^[^ \t]/I p'| sed -e 's/X-Face: //gI' \
|uncompface -X |xbmtopbm|pbmtoascii

