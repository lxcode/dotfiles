#!/bin/sh

cat <<EOF >> /etc/rc.conf
# Added by fix_fbsd
virecover_enable="NO"
ntpd_sync_on_start="YES"
clear_tmp_enable="YES"
keymap="us.pc-ctrl.kbd"
keyrate="fast"
EOF

cat <<EOF >> /etc/make.conf
OPTIONS_UNSET=CUPS PRINT DEBUG NLS HELP TEST
EOF

cat <<EOF >> /boot/loader.conf
sem_load="YES"
autoboot_delay="3"
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
hw.syscons.bell=0
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


read -p "Install packages?"
pkg install vim-console zsh fzf tmux mosh sudo portmaster git \
    w3m curl runit par ripgrep fd-find gnupg mutt htop apg mtr

read -p "Install GUI crap?"
pkg install inconsolata-ttf dmenu metalock xautolock xorg sakura \
    sourcecodepro-ttf xcape chromium cmus dbus autocutsel gnome-keyring \
    ibus redshift

cat <<EOF >> /etc/rc.conf
dbus_enable="YES"
ibus_enable="YES"
webcamd_enable="YES"
powerd_enable="YES"
kld_list="/boot/modules/i915kms.ko"
EOF
