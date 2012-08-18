#!/usr/bin/awk

BEGIN {x = $3; printf("x = %d decimal, %x hex, %o octal.\n",x,x,x); exit}

