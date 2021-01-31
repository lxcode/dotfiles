set loadpath '~/bin'
load "gpsettings.gp"
#load "rdgy.pal"

set yrange [0:*]      # start at zero, find max from the data
set style fill solid  # solid color boxes
unset key             # turn off all titles
set ytics nomirror
set format x '%.0f'
#set format x '%.0s%c'   # For abbreviated nums
#set lmargin screen 0.40 # To deal with too much space on the left

myBoxWidth = 0.8
set offsets 0,0,0.5-myBoxWidth/2.,0.5
unset colorbox

# Skip first line, the header
plot '/tmp/in.tsv' skip 1 using 2:0:(0):2:($0-myBoxWidth/2.):($0+myBoxWidth/2.):($0+1):ytic(1) with boxxyerror lt rgb "#8C1515"
