# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.box_check_update = false
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--usb", "on"]
    vb.customize ["modifyvm", :id, "--usbehci", "off"]
    vb.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
    vb.customize ["modifyvm", :id, "--nicpromisc3", "allow-all"]
    vb.customize ["modifyvm", :id, "--nicpromisc4", "allow-all"]
    vb.customize ["modifyvm", :id, "--nicpromisc5", "allow-all"]
    vb.memory = 256
    vb.cpus = 1
  end
#  config.vm.define "router-1" do |router1|
#    router1.vm.box = "minimal/trusty64"
#    router1.vm.hostname = "router-1"
#    router1.vm.network "private_network", virtualbox__intnet: "broadcast_router-south-1", auto_config: false
#    router1.vm.network "private_network", virtualbox__intnet: "broadcast_router-inter", auto_config: false
#    router1.vm.provision "shell", path: "router-1.sh"
#  end
#  config.vm.define "router-2" do |router2|
#    router2.vm.box = "minimal/trusty64"
#    router2.vm.hostname = "router-2"
#    router2.vm.network "private_network", virtualbox__intnet: "broadcast_router-south-2", auto_config: false
#    router2.vm.network "private_network", virtualbox__intnet: "broadcast_router-inter", auto_config: false
#    router2.vm.provision "shell", path: "router-2.sh"
#  end
  config.vm.define "switch-1" do |switch1|
    switch1.vm.box = "minimal/trusty64"
    switch1.vm.hostname = "switch-1"
    switch1.vm.network "private_network", virtualbox__intnet: "broadcast_switch-north-2", auto_config: false
    switch1.vm.network "private_network", virtualbox__intnet: "broadcast_host_a", auto_config: false
    switch1.vm.network "private_network", virtualbox__intnet: "broadcast_host_b", auto_config: false
    switch1.vm.provision "shell", path: "switch-1.sh"
  end
#  config.vm.define "switch-2" do |switch2|
#    switch2.vm.box = "minimal/trusty64"
#    switch2.vm.hostname = "switch-2"
#    switch2.vm.network "private_network", virtualbox__intnet: "broadcast_switch-south-1", auto_config: false
#    switch2.vm.network "private_network", virtualbox__intnet: "broadcast_host_d", auto_config: false
#    switch2.vm.network "private_network", virtualbox__intnet: "broadcast_host_e", auto_config: false
#    switch2.vm.provision "shell", path: "switch-2.sh"
#  end
  config.vm.define "host-1-a" do |hosta|
    hosta.vm.box = "minimal/trusty64"
    hosta.vm.hostname = "host-1-a"
    hosta.vm.network "private_network", virtualbox__intnet: "broadcast_host_a", auto_config: false
    hosta.vm.provision "shell", path: "host-1-a.sh"
  end
  config.vm.define "host-1-b" do |hostb|
    hostb.vm.box = "minimal/trusty64"
    hostb.vm.hostname = "host-1-b"
    hostb.vm.network "private_network", virtualbox__intnet: "broadcast_host_b", auto_config: false
    hostb.vm.provision "shell", path: "host-1-b.sh"
  end
#  config.vm.define "host-2-d" do |hostd|
#    hostd.vm.box = "minimal/trusty64"
#    hostd.vm.hostname = "host-2-d"
#    hostd.vm.network "private_network", virtualbox__intnet: "broadcast_host_d", auto_config: false
#    hostd.vm.provision "shell", path: "host-2-d.sh"
#  end
#  config.vm.define "host-2-e" do |hoste|
#    hoste.vm.box = "minimal/trusty64"
#    hoste.vm.hostname = "host-2-e"
#    hoste.vm.network "private_network", virtualbox__intnet: "broadcast_host_e", auto_config: false
#    hoste.vm.provision "shell", path: "host-2-e.sh"
#  end
#  config.vm.define "host-2-c" do |hostc|
#    hostc.vm.box = "minimal/trusty64"
#    hostc.vm.hostname = "host-2-c"
#    hostc.vm.network "private_network", virtualbox__intnet: "broadcast_router-south-2", auto_config: false
#    hostc.vm.provision "shell", path: "host-2-c.sh"
#  end
end

