
DEBUG=debug
LOG=/tmp/debug.install.$(basename $0).log

MYDIR="/tmp/install"

# By default the terminus-console is installed
# You can include here other:

ZONEINFO="Europe/Madrid"

HOSTNAME="panzer"
MYIP="192.168.1.123"

PACMAN_CACHE_PATH="/tmp/sdd1/var.cache.pacman/pkg"

if [ -z "$DEBUG" ]; then true
else
	alias clear='echo ""'
	exec 1>>$LOG
	exec 2>&1
	set -x
fi


