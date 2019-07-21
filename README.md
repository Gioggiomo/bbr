# BBR performance analysis

This repository contains the Vagrant files required to run the virtual lab environment for BBR performance analysis of the DNCS course.

## Requirements

 - Debian or alternative OS for the VMs (Linux kernel 4.9 or newer is required for BBR test)
 - Disk storage
   - 16 GB for 6 VMs running Debian 9 OS  
   - 48 GB (18 VMs) if you build and keep *all* the VMs with different TCP versions
 - 3GB free RAM
 - Virtualbox
 - Vagrant (https://www.vagrantup.com )
 - Internet
 - gnuplot (if you plan to plot the data in your OS)

## A priori note

Since my laptop does not like a VM with Ubuntu where to build others VMs (it crashed while building the second VM), all the tests have been done running on Windows 10 OS. This means that if you are running a different OS, you may need to adjust something in the code.
Given that, let's begin! 

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
`vagrant ssh router-1`
`vagrant ssh router-2`
`vagrant ssh host-1-a`
`vagrant ssh host-1-b`
`vagrant ssh host-2-c`
`vagrant ssh host-2-d`

 - You can save you work, turn-off the VMs and exit from vagrant at any time by typing the command below
`vagrant global-status | awk '/running/{print $1}' | xargs -r -d '\n' -n 1 -- vagrant suspend` which will result in

```
[~/bbr]$ vagrant global-status | awk '/running/{print $1}' | xargs -r -d '\n' -n 1 -- vagrant suspend
==> router-1: Saving VM state and suspending execution...
==> router-2: Saving VM state and suspending execution...
==> host-1-a: Saving VM state and suspending execution...
==> host-1-b: Saving VM state and suspending execution...
==> host-2-c: Saving VM state and suspending execution...
==> host-2-d: Saving VM state and suspending execution...
```

## Setting the network

```
    +--------------------------------------------+
    |                                            |
+---+---+                                   eth0 |
|       |             +-------------+     +------+------+
|       |        eth0 |             |     |             |
|       +-------------+   host-2-c  |     |  host-2-d   |
|       |             |             |     |             |
|       |             +------+------+     +------+------+
|       |                    |                   |
|       |      172.23.3.2/24 |                   | 172.23.4.2/24
|       |                    |                   |
|       |                    |                   |
|       |                    |                   |
|       |             1 Gbps |                   | 1 Gbps
|       |                    |                   |
|       |                    |                   |
|       |                    |                   |
|       |      172.23.3.1/24 | eth1         eth2 | 172.23.4.1/24
|   V   |                 +--+-------------------+--+
|   A   |            eth0 |                         |
|   G   +-----------------+        router-2         |
|   R   |                 |                         |
|   A   |                 +------------+------------+
|   N   |                172.23.2.2/30 |eth3
|   T   |                              |
|       |                              |
|   M   |                              | 1 Gbps
|   A   |                              |
|   N   |                              |
|   A   |                172.23.2.1/30 |eth3
|   G   |                 +------------+------------+
|   E   |            eth0 |                         |
|   R   +-----------------+        router-1         |
|       |                 |                         |
|       |                 +--+-------------------+--+
|       |      172.23.0.1/24 | eth1         eth2 | 172.23.1.1/24
|       |                    |                   |
|       |                    |                   |
|       |                    |                   |
|       |             1 Gbps |                   | 1 Gbps
|       |                    |                   |
|       |                    |                   |
|       |                    |                   |
|       |      172.23.0.2/24 |                   | 172.23.1.2/24
|       |             +-------------+     +------+------+
|       |        eth0 |             |     |             |
|       +-------------+   host-1-a  |     |  host-1-b   |
|       |             |             |     |             |
+---+---+             +-------------+     +------+------+
    |                                       eth0 |
    +--------------------------------------------+
```

The default connection bandwidth of the links given by VirtualBox ***has been set to be 1 Gbps***. You can have a look in the Vagrant file -- then, in order to have a better analysis of the performance of TCP, I created some bottleneck using `VBoxManage` in the terminal.

**Note** 

> If you are running Windows OS -- whatever version -- you need to open the cmd and go to the path where VBoxManage is (usually located at C:\Program Files\Oracle\VirtualBox, hence `cd C:\Program Files\Oracle\VirtualBox`) otherwise you will not be able to do the steps below.

Now, to create a band limit, you first need to turn save and turn of the VMs because you cannot use the command `modifyvm` which modifies a VM while the VM is running, then you can create a group of all the VMs you want to be band limited with the following command
`VBoxManage bandwidthctl NameOfYourVM add Limit --type network --limit 100m` meaning that the speed will be cut to 100 Mbps. Then you need to add the network interface as reported below:

```
$ VBoxManage bandwidthctl NameOfYourVM add Limit --type network --limit 100m
$ VBoxManage modifyvm NameOfYourVM --nicbandwidthgroup<N> Limit
$ VBoxManage modifyvm NameOfYourVM --nicbandwidthgroup<N+1> Limit
[...]
$ VBoxManage modifyvm NameOfYourVM --nicbandwidthgroup<N+m> Limit
```

These commands will set a bandwidth of 100 Mbps on that specific interface numbered an N. In other words, this means that

 - nicbandwidthgroup1 is referred to Network adapter 1 in VirtualBox GUI;
 - nicbandwidthgroup2 to Network adapter 2;
 - and so on...

After that, it is possible to modify the value of _Limit_ even when the VMs are running. **And this is the only thing you have to do** because all the limits (called Limit) have already been created on every VM when `vagrant up`. You can modify it by using the following command
`VBoxManage bandwidthctl NameOfYourVM set Limit --limit WhatYouWant` 

To be sure that you have done the process properly, you can type
`vboxmanage showvminfo NameOfYourVM --details`
The bandwidth limit description is located close to the end

```
$ vboxmanage showvminfo NameOfYourVM --details

[...]

Bandwidth groups:

Name: 'Limit', Type: Network, Limit: 100 mbits/sec (12500000 bytes/sec)

[...]
```

**Note**

> VM names have been set in vagrant and they are exactly the ones mentioned before. In any case, if you are not sure about their name, just open VirtualBox GUI and check it.

According to the [official VirtualBox manual](https://www.virtualbox.org/manual/ch06.html#network_bandwidth_limit ), such a commands will establish that 
"_that specific VM_" will have a traffic limit of 100 Mbps but ***only in the transmit direction***. This means that if you cut the bandwidth of `router-1` and want to check the TCP performance, you need to use `host-1-a` or `host-1-b` as client and
`host-2-c` or `host-2-d` as server.

## Performance evaluation
Now that all the connection of the network have been properly done and there is a band limit, ssh into the desired host and type the command `iperf3 -s` if you want that machine to simulate its behaviour as a server. 
Open now another terminal in the same path and ssh to another host (of the opposite site of the one you have chosen earlier) and type `iperf3 -c IPofTheServer` to simulate the client.

For example, if you have cut the band of `router-1`, then you can use **`iperf3 -s -V -d`** -- -V is for verbose output, -d is for debug -- on `host-2-c` and **`iperf3 -c 172.23.3.2 -V -i 1 -f m -t 120`** -- 120 seconds test and results printed every second in _Mbps_ --  on `host-1-a`. This means that the latter will try to reach the former but the traffic coming at 1 Gbps will be cut to 100 Mbps from `router-1`. Everything by using the default TCP version you have chosen.
In addition, if you want to save the result in a file rather that seeing them in the terminal, you can simply add `>NameOfTheFile` at the end of your _iperf3_ command on the client. By doing so, the above command will become `iperf3 -c 172.23.3.2 -V -i 1 -f m -t 120 >NameOfTheFile`. To see the result, use the command `more NameOfTheFile`.

Below, an example using Cubic as TCP version.
```
vagrant@host-2-c:~$ iperf3 -s
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Accepted connection from  172.23.0.2, port 50268
[  5] local  172.23.3.2 port 5201 connected to  172.23.0.2 port 50270
[ ID] Interval           Transfer     Bandwidth
[  5]   0.00-1.00   sec  12.5 MBytes   105 Mbits/sec
[  5]   1.00-2.00   sec  11.8 MBytes  98.9 Mbits/sec
[  5]   2.00-3.00   sec  11.8 MBytes  99.0 Mbits/sec
[  5]   3.00-4.00   sec  11.8 MBytes  98.9 Mbits/sec
...
...
[  5] 119.00-120.00 sec  11.8 MBytes  99.0 Mbits/sec
[  5] 120.00-120.11 sec  1.29 MBytes  97.9 Mbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bandwidth
[  5]   0.00-120.11 sec  0.00 Bytes  0.00 bits/sec               sender
[  5]   0.00-120.11 sec  1.38 GBytes  99.0 Mbits/sec             receiver
```
```
vagrant@host-1-a$ iperf3 -c 172.23.3.2 -V -i 1 -f m -t 120 >result
vagrant@host-1-a$ more result
Connecting to host  172.23.3.2, port 5201
[  4] local  172.23.0.2 port 50270 connected to  172.23.3.2 port 5201
[ ID] Interval           Transfer     Bandwidth       Retr  Cwnd
[  4]   0.00-1.00   sec  13.8 MBytes   116 Mbits/sec    4    139 KBytes
[  4]   1.00-2.00   sec  12.1 MBytes   102 Mbits/sec    0    194 KBytes
[  4]   2.00-3.00   sec  12.0 MBytes   101 Mbits/sec    0    238 KBytes
[  4]   3.00-4.00   sec  12.0 MBytes   101 Mbits/sec    0    273 KBytes
[  4]   4.00-5.00   sec  11.9 MBytes   100 Mbits/sec    0    304 KBytes
[  4]   5.00-6.00   sec  11.7 MBytes  98.5 Mbits/sec    0    332 KBytes
[  4]   6.00-7.00   sec  11.8 MBytes  99.1 Mbits/sec    0    359 KBytes
[  4]   7.00-8.00   sec  11.8 MBytes  99.0 Mbits/sec    0    383 KBytes
...
...
[  4] 119.00-120.00 sec  11.8 MBytes  99.1 Mbits/sec    0    875 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bandwidth       Retr
[  4]   0.00-120.00 sec  1.38 GBytes  99.1 Mbits/sec  213       sender
[  4]   0.00-120.00 sec  1.38 GBytes  99.1 Mbits/sec            receiver
```
As you can see, 213 retries/retransmissions have been done in 120 seconds using Cubic with a limit of 100 Mbps on router-1

## Plotting the results

Since the results are not so easy and immediate to read, we need to plot them. To do so, `gnuplot` has been used and installed on all the hosts if you wants to use them, otherwise you can install it on your OS.

In order to plot more easily, I suggest to "cut" the previous file as the following
```
vagrant@host-1-a:~$ iperf3 -c 172.23.3.2 -V -i 1 -f m -t 120 >result
vagrant@host-1-a:~$ cat result | grep sec | head -120 | tr - " " | awk '{print $4,$8}' >newResult
vagrant@host-1-a:~$ more newResult
1.00  116
2.00  102
3.00  101
4.00  101
5.00  100
6.00 98.5
7.00 99.1
8.00 99.0
...
...
120.00 99.1
```
Where the first column represent the time and the second column represent the speed, exactly as shown earlier.

Now, you can plot the file using `gnuplot`

**Note**
> As I previously said, since I am using Windows 10 OS, this process is a little bit tricky. I will explain what to ideally do then you have to apply it based on your OS.

To plot the file, type `gnuplot`, then plot the file and set the X and Y labels, also the range of them you need it by doing the following 
```
gnuplot> set xlabel 'Time (s)'                                                                               
gnuplot> set ylabel 'Bandwidth (Mbps)'
gnuplot> p 'NameOfTheCutResult.dat' title 'Put Your Title Here' with lines

```

If you want to plot more than one result on a single graph, you have to put all the column in a single `.dat` file, then 
```
gnuplot> set key below
gnuplot>
gnuplot> set xlabel "Time (s)"
gnuplot> set ylabel "Bandwidth (Mbps)"
gnuplot> set title "TitleOfTheGraph"

gnuplot> plot "NameOfTheCutResult.dat" u 1:2 w l lw 2 t "Label-1", \
              "NameOfTheCutResult.dat" u 1:3 w l lw 2 t "Label-2", \
              "NameOfTheCutResult.dat" u 1:4 w l lw 2 t "Label-3"

```


## What to do next?
By following the same criteria, changing the bandwidth limits and the TCP version, you can check and do any wanted test.

It is possible to find all the results of the test I have done in the folder **results**.


## Final notes
This is a school project of the course *Design of network and communication systems* at the University of Trento, Trento, Italy, held by professor *Fabrizio Granelli*.