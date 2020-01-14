## Домашнее задание
### Настраиваем split-dns
Взять стенд https://github.com/erlong15/vagrant-bind :
- добавить еще один сервер client2
- завести в зоне dns.lab имена:
1. web1 - смотрит на клиент1
2. web2 - смотрит на клиент2
- завести еще одну зону newdns.lab
- завести в ней запись:
1. www - смотрит на обоих клиентов
- настроить split-dns:
1. клиент1 - видит обе зоны, но в зоне dns.lab только web1
2. клиент2 - видит только dns.lab

* настроить все без выключения selinux
Критерии оценки: 4 - основное задание сделано, но есть вопросы
5 - сделано основное задание
6 - выполнено задания со звездочкой

## Домашняя работа
  Добавлен еще один сервер client2. Добавлены имена в зону dns.lab. Заведена новая зона newdns.lab, добавлены имена. Настроено правило для selinux.

#### клиент1 - видит обе зоны, но в зоне dns.lab только web1
```bash
[vagrant@client1 ~]$ host www.newdns.lab
www.newdns.lab has address 192.168.50.16
www.newdns.lab has address 192.168.50.15
[vagrant@client1 ~]$ host web1.dns.lab
web1.dns.lab has address 192.168.50.15
[vagrant@client1 ~]$ host web2.dns.lab
Host web2.dns.lab not found: 3(NXDOMAIN)
```
#### клиент2 - видит только dns.lab
```bash
[vagrant@client2 ~]$ host www.newdns.lab
Host www.newdns.lab not found: 3(NXDOMAIN)
[vagrant@client2 ~]$ host web1.dns.lab
web1.dns.lab has address 192.168.50.15
[vagrant@client2 ~]$ host web2.dns.lab
web2.dns.lab has address 192.168.50.16
```
