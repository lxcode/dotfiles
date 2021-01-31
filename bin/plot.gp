set xdata time
#set timefmt "%Y-%m-%d"
set timefmt "%Y-%m-%d %H:%M"
set format x "%m/%y"
set key off
set xtics rotate by -55
set yrange [0:*]
load "~/bin/gpsettings.gp"

plot '/tmp/in.tsv' skip 1 using 1:2 with points linetype 6 linewidth 1 pointsize 0.3
