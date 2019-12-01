## Домашнее задание
### OSPF

- Поднять три виртуалки
- Объединить их разными private network

1. Поднять OSPF между машинами на базе Quagga
2. Изобразить ассиметричный роутинг
3. Сделать один из линков "дорогим", но что бы при этом роутинг был симметричным

Формат сдачи:
Vagrantfile + ansible

### Домашняя работа

#### 1. Поднять OSPF между машинами на базе Quagga.

  Задиние реализовано с использованием темплейтов и переменных окружения для каждого сервера.
**R1**
```bash
[root@r1 ~]# ip r
default via 10.0.2.2 dev eth0 proto dhcp metric 100
10.0.0.0/30 dev eth1 proto kernel scope link src 10.0.0.1 metric 101
10.0.2.0/24 dev eth0 proto kernel scope link src 10.0.2.15 metric 100
10.10.0.0/30 dev eth2 proto kernel scope link src 10.10.0.1 metric 102
10.20.0.0/30 proto zebra metric 20
	nexthop via 10.0.0.2 dev eth1 weight 1
	nexthop via 10.10.0.2 dev eth2 weight 1
172.30.0.0/30 via 10.0.0.2 dev eth1 proto zebra metric 20

r1# show ip ospf  neighbor  

    Neighbor ID Pri State           Dead Time Address         Interface            RXmtL RqstL DBsmL
10.0.0.2          1 Full/Backup       39.678s 10.0.0.2        eth1:10.0.0.1            0     0     0
10.10.0.2         1 Full/Backup       31.917s 10.10.0.2       eth2:10.10.0.1           0     0     0

r1# show ip ospf route
============ OSPF network routing table ============
N    10.0.0.0/30           [10] area: 0.0.0.0
                           directly attached to eth1
N    10.10.0.0/30          [10] area: 0.0.0.0
                           directly attached to eth2
N    10.20.0.0/30          [20] area: 0.0.0.0
                           via 10.0.0.2, eth1
                           via 10.10.0.2, eth2
N IA 172.30.0.0/30         [20] area: 0.0.0.0
                           via 10.0.0.2, eth1

============ OSPF router routing table =============
R    10.0.0.2              [10] area: 0.0.0.0, ABR
                           via 10.0.0.2, eth1

```
**R2**
```bash
[root@r2 ~]# ip r
default via 10.0.2.2 dev eth0 proto dhcp metric 100
10.0.0.0/30 dev eth1 proto kernel scope link src 10.0.0.2 metric 101
10.0.2.0/24 dev eth0 proto kernel scope link src 10.0.2.15 metric 100
10.10.0.0/30 proto zebra metric 20
	nexthop via 10.0.0.1 dev eth1 weight 1
	nexthop via 10.20.0.1 dev eth2 weight 1
10.20.0.0/30 dev eth2 proto kernel scope link src 10.20.0.2 metric 102
172.30.0.0/30 dev eth3 proto kernel scope link src 172.30.0.1 metric 103

r2# show ip ospf neighbor  

    Neighbor ID Pri State           Dead Time Address         Interface            RXmtL RqstL DBsmL
10.0.0.1          1 Full/DR           39.785s 10.0.0.1        eth1:10.0.0.2            0     0     0
10.10.0.2         1 Full/Backup       33.281s 10.20.0.1       eth2:10.20.0.2           0     0     0
172.30.0.2        1 Full/Backup       39.205s 172.30.0.2      eth3:172.30.0.1          0     0     0

r2# show ip ospf route
============ OSPF network routing table ============
N    10.0.0.0/30           [10] area: 0.0.0.0
                           directly attached to eth1
N    10.10.0.0/30          [20] area: 0.0.0.0
                           via 10.0.0.1, eth1
                           via 10.20.0.1, eth2
N    10.20.0.0/30          [10] area: 0.0.0.0
                           directly attached to eth2
N    172.30.0.0/30         [10] area: 0.0.0.1
                           directly attached to eth3
```
**R3**
```bash
[root@r3 ~]# ip r
default via 10.0.2.2 dev eth0 proto dhcp metric 100
10.0.0.0/30 proto zebra metric 20
	nexthop via 10.10.0.1 dev eth1 weight 1
	nexthop via 10.20.0.2 dev eth2 weight 1
10.0.2.0/24 dev eth0 proto kernel scope link src 10.0.2.15 metric 100
10.10.0.0/30 dev eth1 proto kernel scope link src 10.10.0.2 metric 101
10.20.0.0/30 dev eth2 proto kernel scope link src 10.20.0.1 metric 102
172.30.0.0/30 via 10.20.0.2 dev eth2 proto zebra metric 20

r3# show ip ospf neighbor  

    Neighbor ID Pri State           Dead Time Address         Interface            RXmtL RqstL DBsmL
10.0.0.1          1 Full/DR           38.001s 10.10.0.1       eth1:10.10.0.2           0     0     0
10.0.0.2          1 Full/DR           39.237s 10.20.0.2       eth2:10.20.0.1           0     0     0

r3# show ip ospf route
============ OSPF network routing table ============
N    10.0.0.0/30           [20] area: 0.0.0.0
                           via 10.10.0.1, eth1
                           via 10.20.0.2, eth2
N    10.10.0.0/30          [10] area: 0.0.0.0
                           directly attached to eth1
N    10.20.0.0/30          [10] area: 0.0.0.0
                           directly attached to eth2
N IA 172.30.0.0/30         [20] area: 0.0.0.0
                           via 10.20.0.2, eth2

============ OSPF router routing table =============
R    10.0.0.2              [10] area: 0.0.0.0, ABR
                           via 10.20.0.2, eth2
```
**R4**
```bash
[root@r4 ~]# ip r
default via 10.0.2.2 dev eth0 proto dhcp metric 100
10.0.0.0/30 via 172.30.0.1 dev eth1 proto zebra metric 20
10.0.2.0/24 dev eth0 proto kernel scope link src 10.0.2.15 metric 100
10.10.0.0/30 via 172.30.0.1 dev eth1 proto zebra metric 30
10.20.0.0/30 via 172.30.0.1 dev eth1 proto zebra metric 20
172.30.0.0/30 dev eth1 proto kernel scope link src 172.30.0.2 metric 101

r4# show ip ospf neighbor  

    Neighbor ID Pri State           Dead Time Address         Interface            RXmtL RqstL DBsmL
10.0.0.2          1 Full/DR           37.537s 172.30.0.1      eth1:172.30.0.2          0     0     0

r4# show ip ospf route
============ OSPF network routing table ============
N IA 10.0.0.0/30           [20] area: 0.0.0.1
                           via 172.30.0.1, eth1
N IA 10.10.0.0/30          [30] area: 0.0.0.1
                           via 172.30.0.1, eth1
N IA 10.20.0.0/30          [20] area: 0.0.0.1
                           via 172.30.0.1, eth1
N    172.30.0.0/30         [10] area: 0.0.0.1
                           directly attached to eth1

============ OSPF router routing table =============
R    10.0.0.2              [10] area: 0.0.0.1, ABR
                           via 172.30.0.1, eth1
```

#### 2. Изобразить ассиметричный роутинг

  Использеум tracepath с сервера r4 на r1
```bash
[root@r4 ~]# tracepath 10.0.0.1
 1?: [LOCALHOST]                                         pmtu 1500
 1:  172.30.0.1                                            0.912ms
 1:  172.30.0.1                                            2.474ms
 2:  10.0.0.1                                              0.709ms reached
     Resume: pmtu 1500 hops 2 back 2
[root@r4 ~]# tracepath 10.10.0.1
 1?: [LOCALHOST]                                         pmtu 1500
 1:  172.30.0.1                                            1.290ms
 1:  172.30.0.1                                            0.599ms
 2:  10.10.0.1                                             0.676ms reached
     Resume: pmtu 1500 hops 2 back 2
```
  Увеличим стоимость маршрута между r2 и r1 на 1000
```bash
