#!/bin/sh

eval `dbus-launch --sh-syntax --exit-with-session`
export DBUS_SESSION_BUS_PID
export DBUS_SESSION_BUS_ADDRESS

eval `gnome-keyring-daemon --daemonize --start`
export SSH_AUTH_SOCK
export GPG_AGENT_INFO
export GNOME_KEYRING_CONTROL
export GNOME_KEYRING_PID

#export LC_CTYPE=ja_JP.UTF-8
export XIM=ibus
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=xim
export XMODIFIERS=@im=ibus
export XIM_PROGRAM="ibus-daemon"
export XIM_ARGS="-r --daemonize --xim"
export XDG_RUNTIME_DIR="/tmp"

setxkbmap -option terminate:ctrl_alt_bksp
setxkbmap -option ctrl:nocaps
xcape -e 'Control_L=Escape'
xsetroot -solid black&
xset -b&
xset r rate 400 80&
wmname LG3D&
#xrandr --output VGA1 --right-of LVDS 
autocutsel &
autocutsel -s PRIMARY&
xautolock -time 7 -locker '/usr/local/bin/metalock -F "#404040" -f "-*-fixed-medium-r-normal-*-12-*-*-*-*-*-*-*" -w 1 -P'&

$HOME/bin/dwmstatus.sh | while read line; do xsetroot -name "$line"; done&
while true; do dwm; done

ssh-add -D < /dev/null
eval `ssh-agent -s -k`
