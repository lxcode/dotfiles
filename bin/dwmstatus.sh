#!/bin/sh

xmodmap /usr/home/lx/.Xmodmap 

while true
	do
        fullmem=`sysctl -n \
                vm.stats.vm.v_active_count \
                vm.stats.vm.v_inactive_count \
                vm.stats.vm.v_wire_count \
                vm.stats.vm.v_page_count | tr '\n' ' ' | \
                awk '{print int(100 * ($1 + $2 + $3) / $4) "%"}'`;
    
	batstate=`sysctl -n hw.acpi.battery.state`
        capacity=`sysctl -n hw.acpi.battery.life`
        battery="";

    ssid=`ifconfig wlan0|grep -e ssid|awk '{print $2}'`
    if [ "$ssid" = "no carrier" ];
        then wifi="n/c"
        else wifi="$ssid"
    fi
#    temps=`sysctl dev.cpu |grep temperature|awk '{print $2}'|xargs`

        case "$batstate" in
                2)
                        battery="$capacity% [+]";
                        ;;
                1)
                        battery="$capacity% [-]";
                        ;;
                4)
                        battery="$capacity% [!]";
                        ;;
                5)
                        battery="$capacity% [?]";
                        ;;
                6)
                        battery="$capacity% [+]";
                        ;;
                0)
                        battery="$capacity% [=]";
                        ;;
                *)
                        battery="[N/A]";
        esac
	utime=`uptime | sed -e 's/.*://' -e 's/,//'|awk '{print $1}'` 
	date=`date "+%a %b %d %H:%M"`
	echo " $utime | $fullmem | $battery | $wifi | $date "
	sleep 5
done 
