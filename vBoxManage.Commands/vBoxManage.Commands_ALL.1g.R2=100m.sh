# vboxmanage commands
#R2 100 Mbps

VBoxManage bandwidthctl host-2-c set Limit --limit 1g
VBoxManage bandwidthctl host-2-d set Limit --limit 1g
VBoxManage bandwidthctl host-1-a set Limit --limit 1g
VBoxManage bandwidthctl host-1-b set Limit --limit 1g
VBoxManage bandwidthctl host-1-b set Limit --limit 1g
VBoxManage bandwidthctl router-1 set Limit --limit 1g
VBoxManage bandwidthctl router-2 set Limit --limit 100m

