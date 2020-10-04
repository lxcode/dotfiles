set loadpath '~/bin'
load "gpsettings.gp"
#load "rdgy.pal"

set yrange [0:*]      # start at zero, find max from the data
set style fill solid  # solid color boxes
unset key             # turn off all titles
set ytics nomirror

myBoxWidth = 0.8
set offsets 0,0,0.5-myBoxWidth/2.,0.5
unset colorbox

plot '<cat -' using 2:0:(0):2:($0-myBoxWidth/2.):($0+myBoxWidth/2.):($0+1):ytic(1) with boxxyerror lt rgb "#8C1515"
