binwidth = 86400
bin(t) = (t - (int(t) % binwidth) + binwidth/2)

set xdata time
set timefmt "%Y-%m-%d"
set datafile missing NaN

set boxwidth binwidth

set xtics format "%m/%y" time rotate by -45
set ytics 1
set xtics nomirror
set ytics nomirror
set yrange [0:*]
set key off
set border 1+2

set terminal pngcairo enhanced
set output "/tmp/output.png"

plot '< cat -' using 1:2 with boxes lt 6
