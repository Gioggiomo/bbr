Here it is possible to find the results in `.dat` format and the graphs plotted from them using *gnuplot* and saved in `.png`.


## Single transmission - average

| Settings | bbr | cubic | reno | unit |
| --- | --- | --- | --- | --- |
| All 5 Gbps | 1.2805 | 1.2513 | 1.1041 | Gbps |
| All 5 Gbps but R2 = 1 Gbps | 0.9759 | 0.9936 | 0.9897 | Gbps |
| All 5 Gbps but R1 = 1 Gbps | 0.9608 | 0.9934 | 0.9865 | Gbps |
| All 1 Gbps | 0.9853 | 0.9933 | 0.9940 | Gbps |
| All 1 Gbps but R2 = 100 Mbps | 99.107 | 99.130 | 99.145 | Mbps |
| All 1 Gbps but R1 = 100 Mbps | 99.067 | 99.141 | 99.142 | Mbps |

## Simultaneous transmissions

As shown above, the cutting the bandwidth on the first or the second router does not change that much the overall performance. Hence, below there is no band cap on R2

|  |               BBR              |  |
| --- | :---: | :---: |
| **All 1 Gbps** | | |
|              | **host-1-a --> host-2-c**     |   **host-1-b --> host-2-d** |
| Retransmits       | 43034                     |   29195 |
| Average [Mbps]    | 179                         | 172 |
| | |
| **R1 = 100 Mbps** | | |
| Retransmits       | 2 |                        3 |
| Average [Mbps]    | 48 |                          50.63|
|||
| **All 5 Gbps** | | |
| Retransmits       | 25929                       | 28343 |
| Average [Mbps]        | 136                         | 139 |
|||
| **R1 = 1 Gbps** | | |
| Retransmits   |   23751                     |   29906 |
| Average [Mbps]  | 128                     |     135 |



|               | CUBIC  ||
| --- | :---: | :---: |	
| **All 1 Gbps**      |                           |                        |
|                 |host-1-a --> host-2-c      | host-1-b --> host-2-d  |
| Retransmits      |2002                       | 1739                   |
| Average [Mbps]         |71                         | 69.4                   |
|                 |                           |                        |
| **R1 = 100 Mbps**   |                           |                        |
| Retransmits      |1228                       | 1345                   |
| Average [Mbps]         |44.6                       | 46.1                   |
|                 |                           |                        |
| **All 5 Gbps**      |                           |                        |
| Retransmits      |2109                       | 1891                   |
| Average [Mbps]         |75.1                       | 77.9                   |
|                 |                           |                        |
| **R1 = 1 Gbps**     |                           |                        |
| Retransmits      |1663                       | 1776                   |
| Average [Mbps]         |68.4                       | 68.5                   |



|                 | RENO                      |                         |
| --- | :---: | :---: |	
| **All 1 Gbps**  |
|                 | host-1-a --> host-2-c       | host-1-b --> host-2-d   |
| Retransmits      | 2367                        | 2724                    |
| Average [Mbps]         | 62                          | 59.5                    |
|                 |                             |                         |
| **R1 = 100 Mbps** |                             |                         |
| Retransmits      | 97                          | 1                       |
| Average [Mbps]         | 49.7                        | 49.4                    |
|                 |                             |                         |
| **All 5 Gbps**  |                             |                         |
| Retransmits      | 2546                        | 3028                    |
| Average [Mbps]         | 54.3                        | 57.5                    |
|                 |                             |                         |
| **R1 = 1 Gbps** |                             |                         |
| Retransmits      | 2862                        | 3200                    |
| Average [Mbps]         | 60.3                        | 61.3 |