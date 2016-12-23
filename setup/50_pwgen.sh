#!/bin/bash

chroot /mnt/gentoo /bin/bash <<'EOF'
cat > /etc/init.d/pwgen <<'DATA'
#!/sbin/openrc-run
# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/pwgen/files/pwgen.rc,v 1.4 2006/09/05 16:58:01 wolf31o2 Exp $

depend() {
	before local
}

start() {
	ebegin "Auto-scrambling root password for security"
	echo root:`pwgen -s 16` | chpasswd  > /dev/null 2>&1
	eend $? "Failed to scramble root password."
}

stop() {
	ebegin "Stopping pwgen"
	eend $? "Failed to stop pwgen."
}
DATA
chmod +x /etc/init.d/pwgen
rc-update add pwgen default
EOF
