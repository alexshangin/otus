### Домашнее задание
VPN
1. Между двумя виртуалками поднять vpn в двух режимах. Прочуствовать разницу.
- tun
- tap
2. Поднять RAS на базе OpenVPN с клиентскими сертификатами, подключиться с локальной машины на виртуалку
3. * Самостоятельно изучить, поднять ocserv и подключиться с хоста к виртуалке

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
**-tun**
```bash
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

  Написан bash-скрипт провижена **vpn.sh** для автоматического развертывания OpenVPN. После запуска виртуалки можно на хосте выполняем команды для копирования сертификатов из вм. После чего, вместе с конфигом, копируем из папки **client** в **/etc/OpenVPN** и стартуем его.

```bash
vagrant ssh -c 'cat /opt/ca.crt' > client/ca.crt
vagrant ssh -c 'cat /opt/client.crt' > client/client.crt
vagrant ssh -c 'cat /opt/client.key' > client/client.key
```
![vpn_ping.png](https://github.com/alexshangin/otus/blob/master/lesson21/2/screen/vpn_ping.png)
![vpn_ip_r.png](https://github.com/alexshangin/otus/blob/master/lesson21/2/screen/vpn_ip_r.png)

3. * Самостоятельно изучить, поднять ocserv и подключиться с хоста к виртуалке

  Написан bash-скрипт провижена **ocserv.sh** для автоматического развертывания ocserv. После запуска виртуалки можно подключиться с пользователем **otus** и паролем **12345678** по адресу 192.168.100.100 . В моем случае использовался консольный клиент.

```bash
alexsius@acerhome:~$ sudo openconnect -u otus 192.168.100.100
POST https://192.168.100.100/
Attempting to connect to server 192.168.100.100:443
SSL negotiation with 192.168.100.100
Server certificate verify failed: signer not found

Certificate from VPN server "192.168.100.100" failed verification.
Reason: signer not found
Enter 'yes' to accept, 'no' to abort; anything else to view: yes
Connected to HTTPS on 192.168.100.100
XML POST enabled
Please enter your username.
POST https://192.168.100.100/auth
Please enter your password.
Password:
POST https://192.168.100.100/auth
Got CONNECT response: HTTP/1.1 200 CONNECTED
CSTP connected. DPD 90, Keepalive 32400
Connect Banner:
| Welcome on ocserv Alex Shangin

Connected tun0 as 192.168.10.190, using SSL
Established DTLS connection (using GnuTLS). Ciphersuite (DTLS1.2)-(RSA)-(AES-128-GCM).
```

```bash
alexsius@acerhome:~$ ip a
11: tun0: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 1434 qdisc pfifo_fast state UNKNOWN group default qlen 500
    link/none
    inet 192.168.10.190/32 scope global tun0
       valid_lft forever preferred_lft forever
    inet6 fe80::c281:63a9:f40e:a572/64 scope link flags 800
       valid_lft forever preferred_lft forever
```
