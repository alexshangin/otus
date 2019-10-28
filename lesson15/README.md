## Домашнее задание
### Разворачиваем сетевую лабораторию

#### Планируемая архитектура

  Построить следующую архитектуру:

  Сеть office1:
- 192.168.2.0/26 - dev
- 192.168.2.64/26 - test servers
- 192.168.2.128/26 - managers
- 192.168.2.192/26 - office hardware

  Сеть office2:
- 192.168.1.0/25 - dev
- 192.168.1.128/26 - test servers
- 192.168.1.192/26 - office hardware

  Сеть central:
- 192.168.0.0/28 - directors
- 192.168.0.32/28 - office hardware
- 192.168.0.64/26 - wifi

  Итого должны получится следующие сервера:
- inetRouter
- centralRouter
- office1Router
- office2Router
- centralServer
- office1Server
- office2Server

  Теоретическая часть:
- Найти свободные подсети
- Посчитать сколько узлов в каждой подсети, включая свободные
- Указать broadcast адрес для каждой подсети
- проверить нет ли ошибок при разбиении

  Практическая часть:
- Соединить офисы в сеть согласно схеме и настроить роутинг
- Все сервера и роутеры должны ходить в инет черз inetRouter
- Все сервера должны видеть друг друга
- у всех новых серверов отключить дефолт на нат (eth0), который вагрант поднимает для связи
- при нехватке сетевых интервейсов добавить по несколько адресов на интерфейс

## Домашняя работа

### Практическая часть.

  Написан Vagrantfile для автоматического развертывания сети по схеме и добавления статических мартшрутов.

#### Трассировка до ya.ru, а так же серверов 192.168.[0,1,2].2
![centralRouter.png](https://github.com/alexshangin/otus/blob/master/lesson15/screen/centralRouter.png)
![inetRouter.png](https://github.com/alexshangin/otus/blob/master/lesson15/screen/inetRouter.png)
![centralServer.png](https://github.com/alexshangin/otus/blob/master/lesson15/screen/centralServer.png)
![office1Server.png](https://github.com/alexshangin/otus/blob/master/lesson15/screen/office1Server.png)
![office2Server.png](https://github.com/alexshangin/otus/blob/master/lesson15/screen/office2Server.png)

#### Вывод ip route на маршрутизаторах
![iproute.png](https://github.com/alexshangin/otus/blob/master/lesson15/screen/iproute.png)

### Теоретическая часть.

```bash
## Сеть office1. В сети нет свободных подсетей. Максимальное количество хостов - 248

### - 192.168.2.0/26 - dev
Address:   192.168.2.0          
Netmask:   255.255.255.192 = 26 
Wildcard:  0.0.0.63             
=>
Network:   192.168.2.0/26       
HostMin:   192.168.2.1          
HostMax:   192.168.2.62         
Broadcast: 192.168.2.63         
Hosts/Net: 62                    Class C, Private Internet


### - 192.168.2.64/26 - test servers
Address:   192.168.2.64         
Netmask:   255.255.255.192 = 26 
Wildcard:  0.0.0.63             
=>
Network:   192.168.2.64/26      
HostMin:   192.168.2.65         
HostMax:   192.168.2.126        
Broadcast: 192.168.2.127        
Hosts/Net: 62                    Class C, Private Internet

### - 192.168.2.128/26 - managers
Address:   192.168.2.128        
Netmask:   255.255.255.192 = 26 
Wildcard:  0.0.0.63             
=>
Network:   192.168.2.128/26     
HostMin:   192.168.2.129        
HostMax:   192.168.2.190        
Broadcast: 192.168.2.191        
Hosts/Net: 62                    Class C, Private Internet

### - 192.168.2.192/26 - office hardware
Address:   192.168.2.192        
Netmask:   255.255.255.192 = 26 
Wildcard:  0.0.0.63             
=>
Network:   192.168.2.192/26     
HostMin:   192.168.2.193        
HostMax:   192.168.2.254        
Broadcast: 192.168.2.255        
Hosts/Net: 62                    Class C, Private Internet

## Сеть office2. В сети нет свободных подсетей. Максимальное количество хостов - 250

### - 192.168.1.0/25 - dev
Address:   192.168.1.0          
Netmask:   255.255.255.128 = 25 
Wildcard:  0.0.0.127            
=>
Network:   192.168.1.0/25       
HostMin:   192.168.1.1          
HostMax:   192.168.1.126        
Broadcast: 192.168.1.127        
Hosts/Net: 126                   Class C, Private Internet

### - 192.168.1.128/26 - test servers
Address:   192.168.1.128        
Netmask:   255.255.255.192 = 26 
Wildcard:  0.0.0.63             
=>
Network:   192.168.1.128/26     
HostMin:   192.168.1.129        
HostMax:   192.168.1.190        
Broadcast: 192.168.1.191        
Hosts/Net: 62                    Class C, Private Internet

### - 192.168.1.192/26 - office hardware
Address:   192.168.1.192        
Netmask:   255.255.255.192 = 26 
Wildcard:  0.0.0.63             
=>
Network:   192.168.1.192/26     
HostMin:   192.168.1.193        
HostMax:   192.168.1.254        
Broadcast: 192.168.1.255        
Hosts/Net: 62                    Class C, Private Internet

## Сеть central. В сети есть свободные подсети, список представлен ниже. Максимальное количество хостов - 244

### - 192.168.0.0/28 - directors
Address:   192.168.0.0          
Netmask:   255.255.255.240 = 28 
Wildcard:  0.0.0.15             
=>
Network:   192.168.0.0/28       
HostMin:   192.168.0.1          
HostMax:   192.168.0.14         
Broadcast: 192.168.0.15         
Hosts/Net: 14                    Class C, Private Internet

### - 192.168.0.32/28 - office hardware
Address:   192.168.0.32         
Netmask:   255.255.255.240 = 28 
Wildcard:  0.0.0.15             
=>
Network:   192.168.0.32/28      
HostMin:   192.168.0.33         
HostMax:   192.168.0.46         
Broadcast: 192.168.0.47         
Hosts/Net: 14                    Class C, Private Internet

### - 192.168.0.64/26 - wifi
Address:   192.168.0.64         
Netmask:   255.255.255.192 = 26 
Wildcard:  0.0.0.63             
=>
Network:   192.168.0.64/26      
HostMin:   192.168.0.65         
HostMax:   192.168.0.126        
Broadcast: 192.168.0.127        
Hosts/Net: 62                    Class C, Private Internet

### Список свободных подсетей:
Address:   192.168.0.16         
Netmask:   255.255.255.240 = 28 
Wildcard:  0.0.0.15             
=>
Network:   192.168.0.16/28      
HostMin:   192.168.0.17         
HostMax:   192.168.0.30         
Broadcast: 192.168.0.31         
Hosts/Net: 14                    Class C, Private Internet

Address:   192.168.0.48         
Netmask:   255.255.255.240 = 28 
Wildcard:  0.0.0.15             
=>
Network:   192.168.0.48/28      
HostMin:   192.168.0.49         
HostMax:   192.168.0.62         
Broadcast: 192.168.0.63         
Hosts/Net: 14                    Class C, Private Internet

Address:   192.168.0.128        
Netmask:   255.255.255.128 = 25 
Wildcard:  0.0.0.127            
=>
Network:   192.168.0.128/25     
HostMin:   192.168.0.129        
HostMax:   192.168.0.254        
Broadcast: 192.168.0.255        
Hosts/Net: 126                   Class C, Private Internet
```
