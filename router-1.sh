export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y tcpdump apt-transport-https ca-certificates curl software-properties-common --assume-yes --force-yes
wget -O- https://apps3.cumulusnetworks.com/setup/cumulus-apps-deb.pubkey | apt-key add -
add-apt-repository add-apt-repository "deb [arch=amd64] https://apps3.cumulusnetworks.com/repos/deb $(lsb_release -cs) roh-3"
apt-get update
apt-get install -y frr --assume-yes --force-yes

# Forwarding enabled
sysctl -w net.ipv4.ip_forward=1

# Setting up interface eth1 (South)
ip link set dev eth1 up
ip addr add 172.23.1.29/30 dev eth1

# Setting up interface eth2 (Est)
ip link set dev eth2 up
ip addr add 172.23.1.37/30 dev eth2

# Setting up interface eth3 (South)
ip link set dev eth3 up
ip addr add 172.23.1.25/30 dev eth3

# set router-2 ad default router
ip route del default
ip route add default via 172.23.1.38