######################################################################
#
#      You must change default values
# 
######################################################################

DEBUG="debug"
# disable debug:
# DEBUG=""
MYDIR="/tmp/install"
LOG=/$MYDIR/debug.install.$(basename $0).log

HOSTNAME="myhostname"
DOMAIN="my.domain"
ZONEINFO="Europe/Madrid"
IFACE="eth0"

# Gateway/Router IP
GW="192.168.1.1"
# Interface/Network device
IFACE=$( dmesg | grep '[^ ]*: Link is Down' -o | cut -f1 -d':' )
IFACE=$( cat /proc/net/dev | grep '^.*:' -o | grep -v 'lo:'  | cut -d: -f1 )
# IP/NETWORK MASK
MYIP="192.168.1.213"
IP=$MYIP
NETMASK="24"
# URL for testing purpouses
PING_URL="www.archlinux.org"
# DNS resolver
DNS1="9.9.9.9"
DNS2="8.8.8.8"
# Address for testing purpouses
PING_TEST=$DNS1
# Keyboard layout
KEYS="es"



DISKS="/dev/sda
/dev/sdc"

ZONEINFO="Europe/Madrid"

PACMAN_CACHE_PATH="/tmp/sdd1/var.cache.pacman/pkg"
PACMAN_CACHE_PATH=""

# By default the terminus-console is installed
# You can include here other:
VCONSOLE="

KEYMAP=es
#FONT=ter-v32n
#FONT=ter-v14n
FONT=ter-v16b
# pacman -Ql terminus-font
# ls -la /usr/share/kbd/consolefonts
"

LOCALEGEN="
es_ES.UTF-8 UTF-8
en_US.UTF-8 UTF-8
"

LOCALECONF="
LANG=en_US.UTF-8
#LANG=es_ES.UTF-8
LANGUAGE=es_ES:es
LC_MESSAGES=en_US.UTF-8
LC_ALL=

"

LOG=$MYDIR/debug.install.$(basename $0).log

# By default the terminus-console is installed
# You can include here other:

ZONEINFO="Europe/Madrid"

HOSTNAME="panzer"
MYIP="192.168.1.213"

CONFIG_SSH="\n\nPasswordAuthentication yes\nPermitRootLogin yes\n"


GROUP="usuarios"
GROUPID="12345"
USER="user"
PASSWORD="123456"

# PACMAN CONFIG
REPO='Server = http://www.example.org:8123/$repo/os/$arch'

XORG=" xf86-input-libinput xorg-server xf86-video-intel terminator "
KDE=" kde-applications plasma sddm "
PACKAGES=" git wireless_tools unzip pbzip2 bzip2 net-tools gdisk htop dosfstools exfat-utils ntfs-3g btrfs-progs strace lsof "
YAY=""

PACKAGES_MC=" aspell cabextract p7zip unace unarj unrar zip cdparanoia cdrkit cvs mtools "
OTHER=" ethtool htop git openssh intel-ucode pbzip2 parted xfsprogs $PACKAGES_MC "

EXTRA_PACKAGES=" cronie bind-tools nfs-utils pass "



if [ -z "$DEBUG" ]; then true
else
	alias clear='echo ""'
	exec 1>>$LOG
	exec 2>&1
	set -x
fi

if [ -d "$MYDIR" ]; then 
	ln -s $MYDIR "/install"
fi

if [ -d "/install" ]; then 
	ln -s "/install" $MYDIR
fi

cd $MYDIR
#rm $LOG
#touch $LOG
#tailf $LOG &
