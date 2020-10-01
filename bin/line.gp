set xdata time
set timefmt "%Y-%m-%d"
set format x "%m/%y"
set key off
set xtics rotate by -45 nomirror
set ytics 1
set yrange [0:*]
set terminal pngcairo enhanced
set output "/tmp/output.png"

plot '<cat - ' using 1:2 smooth freq with lines linetype 6 linewidth 2
