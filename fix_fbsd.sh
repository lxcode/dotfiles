#!/bin/sh

cat <<EOF >> /etc/rc.conf
# Added by fix_fbsd
syslogd_flags="-ss"
virecover_enable="NO"
ntpd_sync_on_start="YES"
ntpd_enable="YES"
ntpd_sync_on_start="YES"
clear_tmp_enable="YES"
sendmail_enable="NO"
sendmail_submit_enable="NO"
sendmail_outbound_enable="NO"
sendmail_msp_queue_enable="NO"
keymap="us.ctrl"
keyrate="fast"
#allscreens_flags="-g 132x60 MODE_280"
EOF

cat <<EOF >> /etc/make.conf
OPTIONS_UNSET=CUPS PRINT DEBUG NLS HELP TEST
WITH_XTERM_COLOR=1
NO_FORTRAN=     true
NO_IPFILTER=    true
NO_LPR= true
NO_NIS= true
NO_VINUM=       true
NO_BIND=        true
NO_ATM= true
NO_I4B= true
EOF

cat <<EOF >> /boot/loader.conf
sem_load="YES"
autoboot_delay="3"
EOF

cat <<EOF >> /etc/mergemaster.rc
# Automatically install files that do not exist
AUTO_INSTALL='yes'
# Automatically upgrade files that have not been edited
AUTO_UPGRADE='yes'
# Ignore files that I don't want changed
IGNORE_FILES='/etc/motd /etc/passwd /etc/group /etc/mail/mailer.conf'
# Ignore CVS id lines to stop replacing files where only that line has changed
DIFF_OPTIONS='-I$FreeBSD:.*[$]'
EOF

cat <<EOF >> /etc/sysctl.conf
kern.ipc.shm_allow_removed=1
net.inet.ip.portrange.reservedlow=0
net.inet.ip.portrange.reservedhigh=0
net.inet.tcp.blackhole=2
net.inet.udp.blackhole=1
net.inet.ip.random_id=1
security.jail.allow_raw_sockets=1
security.bsd.stack_guard_page=1
EOF

sed -i -e "s/rw/rw,noatime/g" /etc/fstab

read -p "Install packages?"
pkg install vim-lite zsh fzf tmux mosh sudo portmaster git cscope \
    w3m runit par ripgrep gnupg mutt

read -p "Install GUI crap?"
pkg install inconsolata-ttf dmenu metalock xautolock xorg sakura \
    sourcecodepro-ttf xcape firefox cmus dbus autocutsel gnome-keyring \
    ibus

cat <<EOF >> /etc/rc.conf
dbus_enable="YES"
ibus_enable="YES"
EOF
