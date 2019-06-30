# BBR performance analysis

This repository contains the Vagrant files required to run the virtual lab environment for BBR performance analysis of the DNCS course.

```

    +---------------------------------------------
    |                                       eth0 |
+---+---+             +-------------+     +------+------+
|       |             |             |     |             |
|       |        eth0 |   host-2-e  |     |  host-2-d   |
|       +-------------+             |     |             |
|       |             |     BBR     |     |    Cubic    |
|       |             |             |     |             |
|       |             +------+------+     +------+------+
|       |                    |                   |
|       |                    |                   |
|       |                    |                   |
|       |                    |                   |
|       |             1 Gbit |                   | 1 Gbit
|       |                    |                   |
|       |         	     |                   |
|       |                    |                   |
|       |      		     | eth2         eth3 |
|   V   |                 +--+-------------------+--+
|   A   |            eth0 |                         |
|   G   +-----------------+        switch-2         |
|   R   |                 |                         |
|   A   |                 +------------+------------+
|   N   |                              |eth1
|   T   |                              |
|       |                              |
|   M   |                     100 Mbit |
|   A   |                              |
|   N   |                              |
|   A   |                              |eth1
|   G   |                 +------------+------------+
|   E   |            eth0 |                         |
|   R   +-----------------+        switch-1         |
|       |                 |                         |
|       |                 +--+-------------------+--+
|       |                    | eth2         eth3 |
|       |                    |                   |
|       |                    |                   |
|       |                    |                   |
|       |             1 Gbit |                   | 1 Gbit
|       |                    |                   |
|       |         	     |                   |
|       |                    |                   |
|       |      		     |                   |
|       |             +------+------+     +------+------+
|       |             |             |     |             |
|       |        eth0 |   host-1-a  |     |  host-1-b   |
|       +-------------+             |     |             |
|       |             |     BBR     |     |    Cubic    |
|       |             |             |     |             |
+---+---+             +-------------+     +------+------+
    |                                       eth0 |
    +--------------------------------------------+

```

Other details will be added soon...
