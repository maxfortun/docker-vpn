#!/bin/bash -ex
SWD=$(dirname $0)

sed -Ei \
    -e 's!^(\s*\$SystemLogSocketName\s+)(.*)$!\1/dev/log #\2!g' \
    /etc/rsyslog.d/listen.conf

sed -Ei \
    -e 's/^(\s*\$ModLoad\s+imjournal)/#\1/g' \
    -e 's/^(\s*\$IMJournalStateFile\s+imjournal.state)/#\1/g' \
    -e 's/^(\s*\$OmitLocalLogging\s+)(on)/\1off/g' \
    /etc/rsyslog.conf

/usr/bin/ssh-keygen -A

sed -i '/^session.*pam_loginuid.so/s/^session/# session/' /etc/pam.d/sshd

[ -f /usr/lib/tmpfiles.d/systemd-nologin.conf ] && rm /usr/lib/tmpfiles.d/systemd-nologin.conf


