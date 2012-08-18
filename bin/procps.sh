#!/bin/sh 

exec 2>/dev/null
echo "USER UID PID PPID TTY CMD"
for proc in `ls /proc`
do
	DEVNUM=`awk '{print $6}' < /proc/$proc/status`
	TTY=`ls -l /dev|awk '{print $5$6,$10}'|grep $DEVNUM|awk '{print $2}'`
	UID=`awk '{print $12}' < /proc/$proc/status`
	USER=`grep -w $UID  < /etc/passwd | awk -F: '{print $1}'`
	PSLIST=`awk '{print $2,$3}' < /proc/$proc/status`
	CMD=`cat /proc/$proc/cmdline`
	echo $USER $PSLIST $TTY $CMD
done

