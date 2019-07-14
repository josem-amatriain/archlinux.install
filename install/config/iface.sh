######################################################################
#
# You must change default values for iface to repositories
# 
# Gateway/Router IP
GW="192.168.1.1"
# Interface/Network device
IFACE=$( dmesg | grep '[^ ]*: Link is Down' -o | cut -f1 -d':' )
IFACE=$( cat /proc/net/dev | grep '^.*:' -o | grep -v 'lo:'  | cut -d: -f1 )
# IP/NETWORK MASK
IP="192.168.1.40"
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
#######################################################################
