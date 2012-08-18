#!/bin/sh

infile=$1

for host in `grep 80\/open $infile|awk '{print $2}'`
do
    for port in `grep $host $infile|grep -o "[0-9]*\/open\/tcp\/\/http"|awk -F/ '{print $1}'`
    do
        vimprobable http://$host:$port&
        vimprobable https://$host:$port&
        sleep 8
        scrot /tmp/$host:$port.png
        pkill vimprobable
    done
done
