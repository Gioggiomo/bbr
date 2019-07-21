export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y tcpdump apt-transport-https ca-certificates curl software-properties-common --assume-yes --force-yes
wget -O- https://apps3.cumulusnetworks.com/setup/cumulus-apps-deb.pubkey | apt-key add -
add-apt-repository add-apt-repository "deb [arch=amd64] https://apps3.cumulusnetworks.com/repos/deb $(lsb_release -cs) roh-3"
apt-get update
apt-get install -y frr --assume-yes --force-yes


# Forwarding enabled
sysctl -w net.ipv4.ip_forward=1

# setting BBR as TCP congestion control
sysctl -w net.core.default_qdisc=fq
sysctl -w net.ipv4.tcp_congestion_control=bbr

echo "

#################################################
#                                               #
#                                               #
#          TEST ON BBR AUTOMATICALLY SET        #
#                                               #
#                                               #
#             IF YOU SEE AS BELOW               #
#                                               #
#      net.ipv4.tcp_congestion_control=bbr      #
#                                               #
#          EVERYTHING HAS WORKED FINE           #
#                                               #
#                                               #
#                                               #
#################################################


"

# Checking
sysctl -p
sysctl net.ipv4.tcp_congestion_control

# Enable packet pacing to "NGbps"
# sbin/tc qdisc add dev eth1 root fq maxrate Ngbit


# Setting up interface eth1 (North)
ip link set dev eth1 up
ip addr add 172.23.3.1/24 dev eth1

# Setting up interface eth3 (South)
ip link set dev eth3 up
ip addr add 172.23.2.2/30 dev eth3

# Setting up interface eth2 (North)
ip link set dev eth2 up
ip addr add 172.23.4.1/24 dev eth2

# set router-1 ad default router
ip route del default
ip route add default via 172.23.2.1
