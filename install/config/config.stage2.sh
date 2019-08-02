
DEBUG=debug
MYDIR="/install"
LOG=$MYDIR/debug.install.$(basename $0).log


# By default the terminus-console is installed
# You can include here other:

ZONEINFO="Europe/Madrid"

HOSTNAME="panzer"
MYIP="192.168.1.123"
PASSWORD=123456

CONFIG_SSH="\n\nPasswordAuthentication yes\nPermitRootLogin yes\n"


if [ -z "$DEBUG" ]; then true
else
	alias clear='echo ""'
	exec 1>>$LOG
	exec 2>&1
	set -x
fi
