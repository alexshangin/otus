*** Домашнее задание
**** Настройка мониторинга
Настроить дашборд с 4-мя графиками:
1) память
2) процессор
3) диск
4) сеть

Настроить на одной из систем
- zabbix (использовать screen (комплексный экран))
- prometheus - grafana

Использование систем примеры которых не рассматривались на занятии
- список возможных систем был приведен в презентации

*** Домашняя работа

**** Установка NetData.

Скрин основной страницы [netdata.png](https://github.com/alexshangin/otus/blob/master/lesson11/3.NetData/netdata.png)

Установка из консоли:
```bash
yum install -y zlib-devel gcc make git autoconf autogen automake pkgconfig psmisc libuuid-devel
git clone https://github.com/firehol/netdata.git --depth=1
cd netdata/
./netdata-installer.sh
```
Для автоматического развертывания написан playbook.
