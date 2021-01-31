#set style fill solid border lc rgb "black"
#set style fill solid

# I don't remember why I did it this way
#binwidth = 256
#bin(t) = (t - (int(t) % binwidth) + binwidth/2)

#Day binning
#binwidth = 86400
#bin(t) = (t - (int(t) % binwidth))

# Minute binning
binwidth = 60
bin(t) = (t - (int(t) % binwidth))

set xdata time
set timefmt "%Y-%m-%d %H:%M"
set datafile missing NaN

set boxwidth binwidth

set xtics format "%m/%d" time rotate by -55
set xtics nomirror
#set xtics 100000
set ytics nomirror
set yrange [0:*]
#set xrange ["2020-06-27 00:00" : "2020-07-27 00:00"]

set key off
set border 1+2

load "~/bin/gpsettings.gp"

plot '/tmp/in.tsv' skip 1 using 1:2 with boxes lt 6 linewidth 1
