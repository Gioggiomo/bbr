\export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y tcpdump --assume-yes
apt-get install -y openvswitch-common openvswitch-switch apt-transport-https ca-certificates curl software-properties-common

# Hey, I'm a switch!
ovs-vsctl add-br switch

# North to switch-2
#ovs-vsctl add-port switch eth1

# South to host-1-a
ovs-vsctl add-port switch eth2

# South to host-1-b
ovs-vsctl add-port switch eth3

#ip link set eth1 up
ip link set eth2 up
ip link set eth3 up
