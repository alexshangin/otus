## Домашнее задание
### Сценарии iptables
1) реализовать knocking port - centralRouter может попасть на ssh inetrRouter через knock скрипт
2) добавить inetRouter2, который виден(маршрутизируется) с хоста
3) запустить nginx на centralServer
4) пробросить 80й порт на inetRouter2 8080
5) дефолт в инет оставить через inetRouter

## Домашняя работа

1) реализовать knocking port.

  Правила iptables для скрипта **knock_knock.sh** написаны и восстанавливаются в вм из iptables.rules В вм добавлена возможность авторизации по паролю. Для подключениия к inetRouter запускаем скрипт **knock_knock.sh**, после чего можем зайти по **ssh 192.168.255.1**

![knock_knock.png](https://github.com/alexshangin/otus/blob/master/lesson17/screen/knock_knock.png)

2) добавить inetRouter2, который виден(маршрутизируется) с хоста
3) запустить nginx на centralServer
4) пробросить 80й порт на inetRouter2 8080

  Установлен Nginx, на inetRouter2 додбавлены правила редиректа порта, которые мы можем слушать на хосте по адресу 192.168.11.171:8080

![redirect_to_host.png](https://github.com/alexshangin/otus/blob/master/lesson17/screen/redirect_to_host.png)

5) дефолт в инет оставить через inetRouter

![traceroute.png](https://github.com/alexshangin/otus/blob/master/lesson17/screen/traceroute.png)

