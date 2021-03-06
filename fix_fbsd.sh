#!/bin/sh

cat <<EOF >> /etc/rc.conf
# Added by fix_fbsd
virecover_enable="NO"
ntpd_sync_on_start="YES"
clear_tmp_enable="YES"
keymap="us.ctrl"
keyrate="fast"
allscreens_kbdflags="-b quiet.off"
syslogd_flags="-ss"
sendmail_enable="NO"
sendmail_submit_enable="NO"
sendmail_outbound_enable="NO"
sendmail_msp_queue_enable="NO"
local_unbound_enable="YES"
EOF

cat <<EOF >> /etc/periodic.conf >> /etc/periodic.conf
daily_output=/dev/null
weekly_output=/dev/null
monthly_output=/dev/null
EOF

cat <<EOF >> /etc/make.conf
OPTIONS_UNSET=CUPS PRINT DEBUG NLS HELP TEST
EOF

cat <<EOF >> /etc/fstab
tmpfs /tmp tmpfs rw,mode=1777 0 0
EOF

cat <<EOF >> /boot/loader.conf
sem_load="YES"
tmpfs_load="YES"
autoboot_delay="3"
EOF

cat <<EOF >> /etc/sysctl.conf
net.inet.ip.portrange.reservedlow=0
net.inet.ip.portrange.reservedhigh=0
net.inet.tcp.blackhole=2
net.inet.udp.blackhole=1
net.inet.ip.random_id=1
security.jail.allow_raw_sockets=1
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
pkg install vim-console zsh fzf tmux mosh sudo portmaster git-lite \
    w3m curl runit par_format ripgrep fd-find gnupg mutt gotop apg mtr-nox11

read -p "Install GUI crap?"
pkg install inconsolata-ttf dmenu metalock xautolock xorg sakura \
    sourcecodepro-ttf xcape chromium cmus dbus autocutsel gnome-keyring \
    ibus redshift alacritty symbola

cat <<EOF >> /etc/rc.conf
dbus_enable="YES"
ibus_enable="YES"
webcamd_enable="YES"
kld_list="/boot/modules/i915kms.ko"
EOF

cat <<EOF >> /boot/loader.conf
cuse_load="YES"
wmt_load="YES"
acpi_video_load="YES"
mmc_load="YES"
mmcsd_load="YES"
sdhci_load="YES"
coretemp_load="YES"
EOF

cat <<EOF >> /etc/sysctl.conf
hw.psm.tap_timeout=0
hw.acpi.lid_switch_state=S3
kern.sched.preempt_thresh=224
EOF

cd dwm && make install
