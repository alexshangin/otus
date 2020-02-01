## Домашнее задание
### OSPF

- Поднять три виртуалки
- Объединить их разными private network
1. Поднять OSPF между машинами на базе Quagga
2. Изобразить ассиметричный роутинг
3. Сделать один из линков "дорогим", но что бы при этом роутинг был симметричным

### Домашняя работа
#### 1. Поднять OSPF между машинами на базе Quagga.
  Для запуска стенда с развернутым OSPF выполним команду **vagrant up**. Проверяем маршруты.
**R1**
```bash
[vagrant@R1 ~]$ ip r
default via 10.0.2.2 dev eth0 proto dhcp metric 100
10.0.2.0/24 dev eth0 proto kernel scope link src 10.0.2.15 metric 100
10.10.10.0/24 dev eth3 proto kernel scope link src 10.10.10.1 metric 103
10.20.20.0/24 via 192.168.10.2 dev vlan10 proto zebra metric 20
10.30.30.0/24 via 192.168.30.1 dev vlan30 proto zebra metric 20
192.168.10.0/24 dev vlan10 proto kernel scope link src 192.168.10.1 metric 401
192.168.20.0/24 proto zebra metric 20
	nexthop via 192.168.30.1 dev vlan30 weight 1
	nexthop via 192.168.10.2 dev vlan10 weight 1
192.168.30.0/24 dev vlan30 proto kernel scope link src 192.168.30.2 metric 400

R1# show ip ospf  neighbor
    Neighbor ID Pri State           Dead Time Address         Interface            RXmtL RqstL DBsmL
10.30.30.1        1 Full/DR           31.185s 192.168.30.1    vlan30:192.168.30.2      0     0     0
10.20.20.1        1 Full/DR           31.170s 192.168.10.2    vlan10:192.168.10.1      0     0     0

R1# show ip ospf route
============ OSPF network routing table ============
N    10.10.10.0/24         [10] area: 0.0.0.1
                           directly attached to eth3
N IA 10.20.20.0/24         [20] area: 0.0.0.0
                           via 192.168.10.2, vlan10
N IA 10.30.30.0/24         [20] area: 0.0.0.0
                           via 192.168.30.1, vlan30
N    192.168.10.0/24       [10] area: 0.0.0.0
                           directly attached to vlan10
N    192.168.20.0/24       [20] area: 0.0.0.0
                           via 192.168.30.1, vlan30
                           via 192.168.10.2, vlan10
N    192.168.30.0/24       [10] area: 0.0.0.0
                           directly attached to vlan30
============ OSPF router routing table =============
R    10.20.20.1            [10] area: 0.0.0.0, ABR
                           via 192.168.10.2, vlan10
R    10.30.30.1            [10] area: 0.0.0.0, ABR
                           via 192.168.30.1, vlan30
============ OSPF external routing table ===========
```
**R2**
```bash
[vagrant@R2 ~]$ ip r
default via 10.0.2.2 dev eth0 proto dhcp metric 100
10.0.2.0/24 dev eth0 proto kernel scope link src 10.0.2.15 metric 100
10.10.10.0/24 via 192.168.10.1 dev vlan10 proto zebra metric 20
10.20.20.0/24 dev eth3 proto kernel scope link src 10.20.20.1 metric 103
10.30.30.0/24 via 192.168.20.2 dev vlan20 proto zebra metric 20
192.168.10.0/24 dev vlan10 proto kernel scope link src 192.168.10.2 metric 400
192.168.20.0/24 dev vlan20 proto kernel scope link src 192.168.20.1 metric 401
192.168.30.0/24 proto zebra metric 20
	nexthop via 192.168.10.1 dev vlan10 weight 1
	nexthop via 192.168.20.2 dev vlan20 weight 1

[root@R2 vagrant]# vtysh
R2# show ip ospf neighbor
    Neighbor ID Pri State           Dead Time Address         Interface            RXmtL RqstL DBsmL
10.10.10.1        1 Full/Backup       31.572s 192.168.10.1    vlan10:192.168.10.2      0     0     0
10.30.30.1        1 Full/DR           31.845s 192.168.20.2    vlan20:192.168.20.1      0     0     0

R2# show ip ospf route
============ OSPF network routing table ============
N IA 10.10.10.0/24         [20] area: 0.0.0.0
                           via 192.168.10.1, vlan10
N    10.20.20.0/24         [10] area: 0.0.0.1
                           directly attached to eth3
N IA 10.30.30.0/24         [20] area: 0.0.0.0
                           via 192.168.20.2, vlan20
N    192.168.10.0/24       [10] area: 0.0.0.0
                           directly attached to vlan10
N    192.168.20.0/24       [10] area: 0.0.0.0
                           directly attached to vlan20
N    192.168.30.0/24       [20] area: 0.0.0.0
                           via 192.168.10.1, vlan10
                           via 192.168.20.2, vlan20
============ OSPF router routing table =============
R    10.10.10.1            [10] area: 0.0.0.0, ABR
                           via 192.168.10.1, vlan10
R    10.30.30.1            [10] area: 0.0.0.0, ABR
                           via 192.168.20.2, vlan20
============ OSPF external routing table ===========
```
**R3**
```bash
[vagrant@R3 ~]$ ip r
default via 10.0.2.2 dev eth0 proto dhcp metric 100
10.0.2.0/24 dev eth0 proto kernel scope link src 10.0.2.15 metric 100
10.10.10.0/24 via 192.168.30.2 dev vlan30 proto zebra metric 20
10.20.20.0/24 via 192.168.20.1 dev vlan20 proto zebra metric 20
10.30.30.0/24 dev eth3 proto kernel scope link src 10.30.30.1 metric 103
192.168.10.0/24 proto zebra metric 20
	nexthop via 192.168.20.1 dev vlan20 weight 1
	nexthop via 192.168.30.2 dev vlan30 weight 1
192.168.20.0/24 dev vlan20 proto kernel scope link src 192.168.20.2 metric 400
192.168.30.0/24 dev vlan30 proto kernel scope link src 192.168.30.1 metric 401

[root@R3 vagrant]# vtysh
R3# show ip ospf neighbor
    Neighbor ID Pri State           Dead Time Address         Interface            RXmtL RqstL DBsmL
10.20.20.1        1 Full/Backup       39.691s 192.168.20.1    vlan20:192.168.20.2      0     0     0
10.10.10.1        1 Full/Backup       39.429s 192.168.30.2    vlan30:192.168.30.1      0     0     0

R3# show ip ospf route
============ OSPF network routing table ============
N IA 10.10.10.0/24         [20] area: 0.0.0.0
                           via 192.168.30.2, vlan30
N IA 10.20.20.0/24         [20] area: 0.0.0.0
                           via 192.168.20.1, vlan20
N    10.30.30.0/24         [10] area: 0.0.0.1
                           directly attached to eth3
N    192.168.10.0/24       [20] area: 0.0.0.0
                           via 192.168.20.1, vlan20
                           via 192.168.30.2, vlan30
N    192.168.20.0/24       [10] area: 0.0.0.0
                           directly attached to vlan20
N    192.168.30.0/24       [10] area: 0.0.0.0
                           directly attached to vlan30
============ OSPF router routing table =============
R    10.10.10.1            [10] area: 0.0.0.0, ABR
                           via 192.168.30.2, vlan30
R    10.20.20.1            [10] area: 0.0.0.0, ABR
                           via 192.168.20.1, vlan20
============ OSPF external routing table ===========
```
#### 2. Изобразить ассиметричный роутинг
Для этого выполняем команду **ansible-playbook playbook_asymmetry.yml**, что приведет к увеличению стоимости интерфейса смотрящего в vlan30 на R1. Проверяем и видим, что трассировка теперь ходит через R2.
```bash
[root@R1 vagrant]# tracepath 10.30.30.1
 1?: [LOCALHOST]                                         pmtu 1500
 1:  192.168.10.2                                          1.718ms
 1:  192.168.10.2                                          0.620ms
 2:  10.30.30.1                                            0.843ms reached
     Resume: pmtu 1500 hops 2 back 2
```
#### 3. Сделать один из линков "дорогим", но что бы при этом роутинг был симметричным
Для этого выполняем команду **ansible-playbook palybook_summetry.yml**, что приведет к увеличению стоимости интерфейса смотрящего в vlan30 на R1 и на R3, как итог, vlan30 станет дорогим линком.
