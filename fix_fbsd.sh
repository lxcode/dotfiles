#!/bin/sh

cat <<EOF >> /etc/rc.conf
syslogd_flags="-ss"
virecover_enable="NO"
ntpd_sync_on_start="YES"
ntpd_enable=YES"
clear_tmp_enable="YES"
sendmail_enable="NO"
sendmail_submit_enable="NO"
sendmail_outbound_enable="NO"
sendmail_msp_queue_enable="NO"
keymap="us.pc-ctrl.kbd"
keyrate="fast"
#allscreens_flags="-g 132x60 MODE_280"
EOF

cat <<EOF >> /etc/make.conf
WITH_OPTIONS=1
WITH_XTERM_COLOR=1
WITHOUT_CUPS=1
WITHOUT_PRINT=1
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

sed -i -e "s/rw/rw,noatime/g" /etc/fstab
