
# BBR performance analysis

This repository contains the Vagrant files required to run the virtual lab environment for BBR performance analysis of the DNCS course.

## Requirements
 
 - Debian9 or alternative OS (Linux kernel 4.9 or newer is required for BBR test)
 - 15GB disk storage (every VM has Debian9 and needs 2.2 GB)
 - 3GB free RAM
 - Virtualbox
 - Vagrant (https://www.vagrantup.com)
 - Internet
 
## How-to
 - Install Virtualbox and Vagrant
 - Clone this repository
`git clone https://github.com/Gioggiomo/bbr`
 - You should be able to launch it from within the cloned repo folder.
```
cd bbr
[~/bbr]$ vagrant up
```
Once you launch the vagrant script, it may take a while for the entire topology to become available.
 - Verify the status of the 6 VMs
```
[~/bbr]$ vagrant status
Current machine states:

router-1                  running (virtualbox)
router-2                  running (virtualbox)
host-1-a                  running (virtualbox)
host-1-b                  running (virtualbox)
host-2-c                  running (virtualbox)
host-2-d                  running (virtualbox)
```
- Once all the VMs are running verify you can log into all of them by typing:
`vagrant ssh router-1`, 
`vagrant ssh router-2`
`vagrant ssh host-1-a`
`vagrant ssh host-1-b`
`vagrant ssh host-2-c`
`vagrant ssh host-2-d`

- You can now save you work, turn-off the VMs and exit from vagrant by typing the command `vagrant global-status | awk '/running/{print $1}' | xargs -r -d '\n' -n 1 -- vagrant suspend` which will result in
```
[~/bbr]$ vagrant global-status | awk '/running/{print $1}' | xargs -r -d '\n' -n 1 -- vagrant suspend
==> router-1: Saving VM state and suspending execution...
==> host-1-a: Saving VM state and suspending execution...
==> host-1-b: Saving VM state and suspending execution...
 ...
 

```

### Network diagram

```

    +--------------------------------------------+
    |                                       eth0 |
+---+---+             +-------------+     +------+------+
|       |             |             |     |             |
|       |        eth0 |   host-2-d  |     |  host-2-c   |
|       +-------------+             |     |             |
|       |             |     BBR     |     |    Cubic    |
|       |             |             |     |             |
|       |             +------+------+     +------+------+
|       |     172.23.1.42/30 |                   | 172.23.1.34/30
|       |                    |                   |
|       |                    |                   |
|       |                    |                   |
|       |             1 Gbps |                   | 1 Gbps
|       |                    |                   |
|       |          	         |                   |
|       |                    |                   |
|       |     172.23.1.41/30 | eth1         eth3 | 172.23.1.33/30
|   V   |                 +--+-------------------+--+
|   A   |            eth0 |                         |
|   G   +-----------------+        router-2         |
|   R   |                 |                         |
|   A   |                 +------------+------------+
|   N   |               172.23.1.38/30 |eth2
|   T   |                              |
|       |                              |
|   M   |                              | 100 Mbps
|   A   |                              |
|   N   |                              |
|   A   |               172.23.1.37/30 |eth2
|   G   |                 +------------+------------+
|   E   |            eth0 |                         |
|   R   +-----------------+        router-1         |
|       |                 |                         |
|       |                 +--+-------------------+--+
|       |     172.23.1.29/30 | eth1         eth3 | 172.23.1.25/30
|       |                    |                   |
|       |                    |                   |
|       |                    |                   |
|       |             1 Gbps |                   | 1 Gbps
|       |                    |                   |
|       |         	         |                   |
|       |                    |                   |
|       |     172.23.1.30/30 |                   | 172.23.1.26/30
|       |             +------+------+     +------+------+
|       |             |             |     |             |
|       |        eth0 |   host-1-a  |     |  host-1-b   |
|       +-------------+             |     |             |
|       |             |    Cubic    |     |     BBR     |
|       |             |             |     |             |
+---+---+             +-------------+     +------+------+
    |                                       eth0 |
    +--------------------------------------------+

```

The default connection bandwidth of the links given by VirtualBox is 1 Gbps. In order to analyse the performance of TCP, we need to create a bottleneck between the two routers. To do so, we need to use `VBoxManage` in the terminal.

Note
: if you are running Windows OS -- whatever version -- you need to open the cmd and go to the path where VBoxManage is (usually located at C:\Program Files\Oracle\VirtualBox) otherwise you will not be able to do the steps below.

Now, to create the bottleneck, create a group of all the VMs we want to be band limited with the following command 
`VBoxManage bandwidthctl NameOfYourVM add Limit --type network --limit 100m` meaning that the speed will be cut to 100 Mbps.
To be sure that you have done the process properly, you can type
`vboxmanage showvminfo NameOfYourVM --details`
The bandwidth limit description is located close to the end

```
[~/bbr]$ vboxmanage showvminfo NameOfYourVM --details

...

Bandwidth groups:

Name: 'Limit', Type: Network, Limit: 100 mbits/sec (12500000 bytes/sec)

...

```

Note
: if you are not sure about the name of the VM, must open VirtualBox and check the the name.

According to the [official VirtualBox Website](https://www.virtualbox.org/manual/ch06.html#network_bandwidth_limit ), such a command will establish that 
"_that specific VM_" will have a traffic limit of 100 Mbps but ***only in the transmit direction***.  This means that if you cut the bandwidth of `router-1` and want to check the TCP performance, you need to use `host-1-a` or `host-1-b` as client and
`host-2-c` or `host-2-d` as server.

_How to do that_? Simple, just ssh into the desired host and type the command `iperf3 -s` if you want that machine to simulate its behaviour as a server.
Open now another terminal in the same path and ssh to another host (of the opposite site of the one you have chosen earlier) and type `iperf3 -c IPofTheServer`

For example, if you have cut the band of `router-1`, then you can use **`iperf3 -s`** on `host-2-d` and **`iperf3 -c 172.23.1.42 -i 1 -t 30`** -- 30 seconds test and result every second --  on `host-2-b`. This means that the latter will try to reach the former but the traffic coming at 1 Gbps from it will be cut to 100 Mbps from `router-1`.


```
Show what happens


```

Other details will be added soon...
