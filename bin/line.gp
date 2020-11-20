set xdata time
#set timefmt "%Y-%m-%d"
set timefmt "%Y-%m-%d %H:%M"
set format x "%m/%d"
set key off
set xtics rotate by -55 nomirror
set yrange [0:*]
load "~/bin/gpsettings.gp"

plot '/tmp/in.csv' using 1:2 smooth freq with lines linetype 6 linewidth 2
