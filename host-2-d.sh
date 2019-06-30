export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y tcpdump --assume-yes
apt-get install -y curl --assume-yes

# Setting up eth3 interface (South)
ip link set dev eth3 up

# What's my address?
ip addr add 172.23.1.34/30 dev eth3

# Where should I go?
#ip route del default
#ip route add default via 172.23.0.1


