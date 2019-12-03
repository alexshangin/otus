### Домашнее задание
VPN
1. Между двумя виртуалками поднять vpn в двух режимах. Прочуствовать разницу.
- tun
- tap
2. Поднять RAS на базе OpenVPN с клиентскими сертификатами, подключиться с локальной машины на виртуалку
3. *Самостоятельно изучить, поднять ocserv и подключиться с хоста к виртуалке

### Домашняя работа
1. Между двумя виртуалками поднять vpn в режимах
**-tap**
```bash
[root@vpnclient ~]# iperf3 -c 10.10.10.1 -t 40 -i 5
Connecting to host 10.10.10.1, port 5201
[  4] local 10.10.10.2 port 54354 connected to 10.10.10.1 port 5201
[ ID] Interval           Transfer     Bandwidth       Retr  Cwnd
[  4]   0.00-5.00   sec   121 MBytes   204 Mbits/sec  142    355 KBytes       
[  4]   5.00-10.00  sec   123 MBytes   207 Mbits/sec   64    383 KBytes       
[  4]  10.00-15.00  sec   127 MBytes   213 Mbits/sec   47    391 KBytes       
[  4]  15.00-20.01  sec   128 MBytes   214 Mbits/sec   40    285 KBytes       
[  4]  20.01-25.00  sec   126 MBytes   212 Mbits/sec  103    369 KBytes       
[  4]  25.00-30.01  sec   129 MBytes   216 Mbits/sec   37    435 KBytes       
[  4]  30.01-35.01  sec   127 MBytes   213 Mbits/sec   86    302 KBytes       
[  4]  35.01-40.01  sec   127 MBytes   213 Mbits/sec   56    334 KBytes       
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bandwidth       Retr
[  4]   0.00-40.01  sec  1008 MBytes   211 Mbits/sec  575             sender
[  4]   0.00-40.01  sec  1006 MBytes   211 Mbits/sec                  receiver
iperf Done.
```
```bash
**-tun**
[root@vpnclient ~]# iperf3 -c 10.10.10.1 -t 40 -i 5
Connecting to host 10.10.10.1, port 5201
[  4] local 10.10.10.2 port 54526 connected to 10.10.10.1 port 5201
[ ID] Interval           Transfer     Bandwidth       Retr  Cwnd
[  4]   0.00-5.00   sec   128 MBytes   215 Mbits/sec   74    344 KBytes       
[  4]   5.00-10.01  sec   128 MBytes   215 Mbits/sec   80    428 KBytes       
[  4]  10.01-15.00  sec   128 MBytes   216 Mbits/sec   92    399 KBytes       
[  4]  15.00-20.01  sec   129 MBytes   216 Mbits/sec  162    285 KBytes       
[  4]  20.01-25.00  sec   128 MBytes   216 Mbits/sec  158    334 KBytes       
[  4]  25.00-30.00  sec   129 MBytes   217 Mbits/sec   74    382 KBytes       
[  4]  30.00-35.00  sec   129 MBytes   217 Mbits/sec  229    440 KBytes       
[  4]  35.00-40.00  sec   130 MBytes   218 Mbits/sec   41    497 KBytes       
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bandwidth       Retr
[  4]   0.00-40.00  sec  1.01 GBytes   216 Mbits/sec  910             sender
[  4]   0.00-40.00  sec  1.01 GBytes   216 Mbits/sec                  receiver
iperf Done.
```
  По итогу видно, что в тонеле tun данных отправлено примерно на 40% больше.

2. Поднять RAS на базе OpenVPN с клиентскими сертификатами, подключиться с локальной машины на виртуалку