set xdata time
#set timefmt "%Y-%m-%d"
set timefmt "%Y-%m-%d %H:%M"
set format x "%m/%d"
#set logscale y
set key off
set xtics rotate by -55 nomirror
set yrange [0:*]
#set xrange ["2020-06-20 00:00" : "2020-07-20 00:00"]
#set format y '%.0s%c'
load "~/bin/gpsettings.gp"

#plot '/tmp/in.tsv' using 1:2 smooth csplines with lines linetype 6 linewidth 2
plot '/tmp/in.tsv' skip 1 using 1:2 smooth freq with lines linetype 6 linewidth 2
#plot '/tmp/in.tsv' skip 1 using 1:2 smooth cumulative with lines linetype 6 linewidth 2
