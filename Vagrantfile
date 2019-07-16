# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# you're doing.
# backwards compatibility). Please don't change it unless you know what
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
  config.vm.define "router-1" do |router1|
    router1.vm.box = "generic/debian9"
    router1.vm.hostname = "router-1"
    router1.vm.network "private_network", virtualbox__intnet: "broadcast_router-south-1", auto_config: false
    router1.vm.network "private_network", virtualbox__intnet: "broadcast_router-inter", auto_config: false
    router1.vm.provision "shell", path: "router-1.sh"
    config.vm.provider "virtualbox" do |vb|
      vb.name = "router-1"
    end
  end
  config.vm.define "router-2" do |router2|
    router2.vm.box = "generic/debian9"
    router2.vm.hostname = "router-2"
    router2.vm.network "private_network", virtualbox__intnet: "broadcast_router-south-2", auto_config: false
    router2.vm.network "private_network", virtualbox__intnet: "broadcast_router-inter", auto_config: false
    router2.vm.provision "shell", path: "router-2.sh"
    config.vm.provider "virtualbox" do |vb|
      vb.name = "router-2"
	  end
  end
  config.vm.define "host-1-a" do |hosta|
    hosta.vm.box = "generic/debian9"
    hosta.vm.hostname = "host-1-a"
    hosta.vm.network "private_network", virtualbox__intnet: "broadcast_router-south-1", auto_config: false
    hosta.vm.provision "shell", path: "host-1-a.sh"
    config.vm.provider "virtualbox" do |vb|
      vb.name = "host-1-a"
	end
  end
  config.vm.define "host-1-b" do |hostb|
    hostb.vm.box = "minimal/trusty64"
    hostb.vm.hostname = "host-1-b"
    hostb.vm.network "private_network", virtualbox__intnet: "broadcast_router-south-1", auto_config: false
    hostb.vm.provision "shell", path: "host-1-b.sh"
    config.vm.provider "virtualbox" do |vb|
      vb.name = "host-1-b"
    end
  end
  config.vm.define "host-2-c" do |hostc|
    hostc.vm.box = "generic/debian9"
    hostc.vm.hostname = "host-2-c"
    hostc.vm.network "private_network", virtualbox__intnet: "broadcast_router-south-2", auto_config: false
    hostc.vm.provision "shell", path: "host-2-c.sh"
    config.vm.provider "virtualbox" do |vb|
      vb.name = "host-2-c"
	end
  end
  config.vm.define "host-2-d" do |hostd|
    hostd.vm.box = "generic/debian9"
    hostd.vm.hostname = "host-2-d"
    hostd.vm.network "private_network", virtualbox__intnet: "broadcast_router-south-2", auto_config: false
    hostd.vm.provision "shell", path: "host-2-d.sh"
    config.vm.provider "virtualbox" do |vb|
      vb.name = "host-2-d"
    end
  end
end
