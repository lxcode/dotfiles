#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap

xrdb -merge $userresources
xmodmap $usermodmap
setxkbmap -option terminate:ctrl_alt_bksp&
xsetroot -solid black&
xset -b&
xset r rate 400 80&
nitrogen --restore&

eval `dbus-launch --sh-syntax --exit-with-session`
export DBUS_SESSION_BUS_PID
export DBUS_SESSION_BUS_ADDRESS

#eval `gpg-agent --daemon --default-cache-ttl 8192`
eval `gnome-keyring-daemon --daemonize --start`
export SSH_AUTH_SOCK
export GPG_AGENT_INFO
export GNOME_KEYRING_CONTROL
export GNOME_KEYRING_PID

# if we have private ssh key(s), start ssh-agent and add the key(s)
#export SSH_ASKPASS=/usr/local/bin/ssh-askpass-fullscreen; ssh-add
#id1=$HOME/.ssh/id_dsa
#id2=$HOME/.ssh/id_rsa
#if [ -e /usr/bin/ssh-agent ] && [ -f $id1 -o -f $id2 ];
#then
#        eval `ssh-agent -s`
#        ssh-add $id1 $id2 < /dev/null &
#fi

#LC_CTYPE=ja_JP.UTF-8; export LC_CTYPE
#export LC_CTYPE=en_US.UTF-8
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export XIM=ibus
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=xim
export XMODIFIERS=@im=ibus
export XIM_PROGRAM="ibus-daemon"
export XIM_ARGS="-r --daemonize --xim"

urxvtd&

#xrandr --output VGA1 --right-of LVDS 
wmname LG3D&

setxkbmap -option terminate:ctrl_alt_bksp&
xautolock -time 7 -locker '/usr/local/bin/metalock -F "#404040" -f "-*-fixed-medium-r-normal-*-12-*-*-*-*-*-*-*" -w 1 -P'&

case $OSTYPE in
    darwin*)
        quartz-wm --only proxy &
    ;;
    *)
        autocutsel &
        autocutsel -s PRIMARY&
    ;;
esac

$HOME/bin/dwmstatus.sh | while read line; do xsetroot -name "$line"; done&
while true; do dwm; done

ssh-add -D < /dev/null
eval `ssh-agent -s -k`
