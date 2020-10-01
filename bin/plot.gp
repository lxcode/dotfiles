set xdata time
set timefmt "%Y-%m-%d"
set format x "%m/%y"
set key off
set xtics rotate by -45
set terminal pngcairo
set output "/tmp/output.png"

plot '< cat -' using 1:2 with points linetype 6 linewidth 2
#plot '<cat - ' using 1:2 with lines linetype 6 linewidth 2
