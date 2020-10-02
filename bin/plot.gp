set xdata time
set timefmt "%Y-%m-%d"
set format x "%m/%y"
set key off
set xtics rotate by -55
set yrange [0:*]
load "~/bin/gpsettings.gp"

plot '< cat -' using 1:2 with points linetype 6 linewidth 2 pointsize 0.5
