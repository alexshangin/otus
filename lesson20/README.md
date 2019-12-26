## Домашнее задание
### строим бонды и вланы
  В Office1 в тестовой подсети появляется сервер с доп.интерфесами и адресами в internal сети testLAN:
- testClient1 - 10.10.10.254
- testClient2 - 10.10.10.254
- testServer1- 10.10.10.1
- testServer2- 10.10.10.1

  Изолировать с помощью vlan:
- testClient1 <-> testServer1
- testClient2 <-> testServer2

  Между centralRouter и inetRouter создать 2 линка (общая inernal сеть) и объединить их с помощью bond-интерфейса, проверить работу c отключением сетевых интерфейсов.

### Результат ДЗ: vagrant файл с требуемой конфигурацией
Конфигурация должна разворачиваться с помощью ansible

* реализовать teaming вместо bonding'а (проверить работу в active-active)
** реализовать работу интернета с test машин

## Домашняя работа

  Написан playbook для развертывания конфигурации teaming.
  Проверена работа с отключением интерфейса eth1 на centralRouter

```bash
[root@centralRouter network-scripts]# ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP mode DEFAULT group default qlen 1000
    link/ether 52:54:00:8a:fe:e6 brd ff:ff:ff:ff:ff:ff
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast master team0 state UP mode DEFAULT group default qlen 1000
    link/ether 08:00:27:81:46:8a brd ff:ff:ff:ff:ff:ff
4: eth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast master team0 state UP mode DEFAULT group default qlen 1000
    link/ether 08:00:27:81:46:8a brd ff:ff:ff:ff:ff:ff
5: eth3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP mode DEFAULT group default qlen 1000
    link/ether 08:00:27:ca:ac:c1 brd ff:ff:ff:ff:ff:ff
24: team0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
    link/ether 08:00:27:81:46:8a brd ff:ff:ff:ff:ff:ff
27: VLAN100@eth3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
    link/ether 08:00:27:ca:ac:c1 brd ff:ff:ff:ff:ff:ff
28: VLAN101@eth3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
    link/ether 08:00:27:ca:ac:c1 brd ff:ff:ff:ff:ff:ff
[root@centralRouter network-scripts]#
[root@centralRouter network-scripts]# ip r
default via 192.168.255.1 dev team0 proto static metric 350
10.0.2.0/24 dev eth0 proto kernel scope link src 10.0.2.15 metric 100
10.10.10.0/24 dev VLAN100 proto kernel scope link src 10.10.10.10 metric 400
10.10.10.0/24 dev VLAN101 proto kernel scope link src 10.10.10.11 metric 401
192.168.255.0/24 dev team0 proto kernel scope link src 192.168.255.2 metric 350
[root@centralRouter network-scripts]#
[root@centralRouter network-scripts]# ping -c 4 192.168.255.1
PING 192.168.255.1 (192.168.255.1) 56(84) bytes of data.
64 bytes from 192.168.255.1: icmp_seq=1 ttl=64 time=0.552 ms
64 bytes from 192.168.255.1: icmp_seq=2 ttl=64 time=1.33 ms
64 bytes from 192.168.255.1: icmp_seq=3 ttl=64 time=1.41 ms
64 bytes from 192.168.255.1: icmp_seq=4 ttl=64 time=1.28 ms

--- 192.168.255.1 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3009ms
rtt min/avg/max/mdev = 0.552/1.146/1.416/0.347 ms
[root@centralRouter network-scripts]#
[root@centralRouter network-scripts]# ifdown eth1
Device 'eth1' successfully disconnected.
[root@centralRouter network-scripts]#
[root@centralRouter network-scripts]# ping -c 4 192.168.255.1
PING 192.168.255.1 (192.168.255.1) 56(84) bytes of data.
64 bytes from 192.168.255.1: icmp_seq=1 ttl=64 time=0.947 ms
64 bytes from 192.168.255.1: icmp_seq=2 ttl=64 time=1.24 ms
64 bytes from 192.168.255.1: icmp_seq=3 ttl=64 time=0.949 ms
64 bytes from 192.168.255.1: icmp_seq=4 ttl=64 time=0.981 ms

--- 192.168.255.1 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3008ms
rtt min/avg/max/mdev = 0.947/1.030/1.245/0.128 ms
[root@centralRouter network-scripts]#
[root@centralRouter network-scripts]# ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP mode DEFAULT group default qlen 1000
    link/ether 52:54:00:8a:fe:e6 brd ff:ff:ff:ff:ff:ff
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP mode DEFAULT group default qlen 1000
    link/ether 08:00:27:ad:5e:1c brd ff:ff:ff:ff:ff:ff
4: eth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast master team0 state UP mode DEFAULT group default qlen 1000
    link/ether 08:00:27:81:46:8a brd ff:ff:ff:ff:ff:ff
5: eth3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP mode DEFAULT group default qlen 1000
    link/ether 08:00:27:ca:ac:c1 brd ff:ff:ff:ff:ff:ff
24: team0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
    link/ether 08:00:27:81:46:8a brd ff:ff:ff:ff:ff:ff
27: VLAN100@eth3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
    link/ether 08:00:27:ca:ac:c1 brd ff:ff:ff:ff:ff:ff
28: VLAN101@eth3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
    link/ether 08:00:27:ca:ac:c1 brd ff:ff:ff:ff:ff:ff
[root@centralRouter network-scripts]#
```
  Проверена работа интернета из сети VLAN100

```bash
[root@testServer1 vagrant]# ip r
default via 10.10.10.10 dev VLAN100 proto static metric 400
10.0.2.0/24 dev eth0 proto kernel scope link src 10.0.2.15 metric 100
10.10.10.0/24 dev VLAN100 proto kernel scope link src 10.10.10.254 metric 400
[root@testServer1 vagrant]# ping -c 4 ya.ru
PING ya.ru (87.250.250.242) 56(84) bytes of data.
64 bytes from ya.ru (87.250.250.242): icmp_seq=1 ttl=59 time=42.5 ms
64 bytes from ya.ru (87.250.250.242): icmp_seq=2 ttl=59 time=43.9 ms
64 bytes from ya.ru (87.250.250.242): icmp_seq=3 ttl=59 time=43.4 ms
64 bytes from ya.ru (87.250.250.242): icmp_seq=4 ttl=59 time=43.5 ms

--- ya.ru ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3022ms
rtt min/avg/max/mdev = 42.560/43.390/43.983/0.557 ms
[root@testServer1 vagrant]#
```
  К сожалению не удалось реализовать интернет из сети VLAN101. Адресная сеть на centralRouter для VLAN101 имеет большую метрику. Если её уменьшить, то интернет начинает работать, но перестает для VLAN100.

  Как один из вариантов возможного решения вижу добавление интерфейса для VLAN101 на inetRouter и вывод этой сети в интернет, на centralRouter сделать транк для VLAN101, а для сети VLAN100 включить маскарадинг. Таким образом для inetRouter будут видны две сети 192.168.255.0 и 10.10.10.0(VLAN101).

  Схема сети:
  ![network_map.png](https://github.com/alexshangin/otus/blob/master/lesson20/network_map.png)
