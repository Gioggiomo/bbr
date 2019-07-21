export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y tcpdump --assume-yes
apt-get install -y curl --assume-yes
apt-get install iperf3 -y --assume-yes
apt-get install gnuplot -y --assume-yes


# setting RENO as TCP congestion control
sysctl -w net.core.default_qdisc=fq
sysctl -w net.ipv4.tcp_congestion_control=reno

echo "

#################################################
#                                               #
#                                               #
#         TEST ON RENO AUTOMATICALLY SET        #
#                                               #
#                                               #
#             IF YOU SEE AS BELOW               #
#                                               #
#     net.ipv4.tcp_congestion_control=reno      #
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


# Setting up eth1 interface (North)
ip link set dev eth1 up

# What's my address?
ip addr add 172.23.1.2/24 dev eth1

# Where should I go?
ip route del default
ip route add default via 172.23.1.1