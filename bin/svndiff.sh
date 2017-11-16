#! /bin/sh

TITLE="${5} - ${3}"
TITLE=`echo ${TITLE//(/\\(}`
TITLE=`echo ${TITLE//)/\\)}`
TITLE=`echo ${TITLE// /\\ }`
TITLE=`echo ${TITLE//-/\\-}`

vimdiff ${6} ${7}
