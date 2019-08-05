
SYSCTL_UNIT_PATH="/etc/systemd/system/network_alias@.service"

SYSCTL_UNIT='
[Unit]
Description=Network ALIAS (%i)
Wants=network.target
Before=network.target
#BindsTo=sys-subsystem-net-devices-%i.device
#After=sys-subsystem-net-devices-%i.device

[Service]
Type=oneshot
RemainAfterExit=yes
EnvironmentFile=/etc/conf.d/network_alias@%i

ExecStart=/usr/local/bin/start.alias.sh %i ${address} ${netmask} ${broadcast} ${gateway}

ExecStop=/usr/local/bin/stop.alias.sh %i ${address} ${netmask} ${broadcast} ${gateway}

[Install]
WantedBy=multi-user.target

'


START_PATH='/usr/local/bin/start.alias.sh'
START='#!/bin/bash

dev=$1
address=$2
net=$3
# No se usa
broadcast=$4
gw=$5
alias=$( echo $dev  | cut -d':' -f2 )
iface="$( echo $dev  | cut -d':' -f1 )"
ip addr add   $address/$net   dev $iface label $dev

exit 0

'

STOP_PATH="/usr/local/bin/stop.alias.sh"
STOP='#!/bin/bash

dev=$1
address=$2
net=$3
# No se usa
broadcast=$4
gw=$5

ip  addr del   $address/$net   dev $dev

exit 0

'

if [ -a "$SYSCTL_UNIT_PATH" ]; then true else;
    echo "$SYSCTL_UNIT" > "$SYSCTL_UNIT_PATH"
fi

if [ -a "$START_PATH" ]; then true else;
    echo "$START" > "$START_PATH"
    chmod a+x "$START_PATH"
fi

if [ -a "$STOP_PATH" ]; then true else;
    echo "$STOP" > "$STOP_PATH"
    chmod a+x "$STOP_PATH"
fi
