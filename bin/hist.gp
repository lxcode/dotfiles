binwidth = 86400
bin(t) = (t - (int(t) % binwidth) + binwidth/2)

set xdata time
set timefmt "%Y-%m-%d"
set datafile missing NaN

set boxwidth binwidth

set xtics format "%m/%y" time rotate by -55
set xtics nomirror
set ytics nomirror
set yrange [0:*]
set key off
set border 1+2

load "~/bin/gpsettings.gp"

plot '< cat -' using 1:2 with boxes lt 6 linewidth 3
