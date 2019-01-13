
TXT='
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

echo $TXT > /etc/systemd/system/network_alias@.service

TXT='
interface=enp7s0:1
address=192.168.33.22
netmask=24
broadcast=192.168.33.255
gateway=192.168.33.1
'



device='enp7s0:1'
echo $TXT > "/etc/conf.d/network_alias\@$device"

#
# Add scripts start stop to pat /usr/local/bin
#