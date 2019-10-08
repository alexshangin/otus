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

Скрин основной страницы [zabbix_screen.png](https://github.com/alexshangin/otus/blob/master/lesson11/1.zabbix/zabbix_screen.png)

**** Разворачиваем Zabbix server

# добавляем репы и ставим дополнительные пакеты
```bash
yum install epel-release
yum install wget mc nano
```

# скачиваем и устанавливаем nginx
```bash
rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
yum install nginx
systemctl start nginx
systemctl enable nginx
```

# добавляем репы и устанавливаем php-fpm
```bash
wget http://rpms.remirepo.net/enterprise/remi.repo
yum localinstall remi.repo
wget http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum localinstall remi-release-7.rpm
yum install yum-utils
yum-config-manager --enable remi-php72
yum install php72 php-fpm php-cli php-mysql php-gd php-ldap php-odbc php-pdo php-pecl-memcache php-pear php-xml php-xmlrpc php-mbstring php-snmp php-soap php-bcmath
nano /etc/php-fpm.d/www.conf 
systemctl start php-fpm
systemctl enable php-fpm
```

# добавляем репы, ставим БД и настраиваем
```bash
nano /etc/yum.repos.d/mariadb.repo
yum install MariaDB-server MariaDB-client
systemctl start mariadb
systemctl enable mariadb
/usr/bin/mysql_secure_installation
nano /etc/my.cnf.d/server.cnf
systemctl restart mariadb
systemctl status mariadb.service
```

# скачиваем и устанавливаем Zabbix
```bash
rpm -Uvh https://repo.zabbix.com/zabbix/4.2/rhel/7/x86_64/zabbix-release-4.2-1.el7.noarch.rpm
yum clean all
yum makecache
yum install zabbix-server-mysql zabbix-web-mysql
mysql -uroot -p
zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | mysql -uzabbix -p zabbix
nano /etc/zabbix/zabbix_server.conf
systemctl start zabbix-server
systemctl enable zabbix-server
```

# правим конфиг nginx для zabbix
```bash
nano /etc/nginx/conf.d/default.conf
nginx -t
nginx -s reload
chown -R nginx:nginx /var/lib/php/session
chown -R nginx:nginx /etc/zabbix/web
```

# Добавляем правила firewall
```bash
grep AVC /var/log/audit/audit.log* | audit2allow -M systemd-allow; semodule -i systemd-allow.pp
firewall-cmd --permanent --zone=public --add-service=zabbix-server
setsebool -P nginx_can_connect_zabbix on
setsebool -P nginxd_can_connect_zabbix on
setsebool -P zabbix_can_network=1
cat /var/log/audit/audit.log | grep zabbix_server | grep denied | audit2allow -M zabbix_server_setrlimit > zabbix_server_setrlimit.te
semodule -i zabbix_server_setrlimit.pp
```

# финальный рестарт zabbix
```bash
systemctl restart zabbix-server
```

**** Разворачиваем Zabbix Client

```bash
rpm -Uvh http://repo.zabbix.com/zabbix/2.4/rhel/7/x86_64/zabbix-agent-2.4.1-2.el7.x86_64.rpm
nano /etc/zabbix/zabbix_agentd.conf

Server=192.168.11.111
ServerActive=192.168.11.111
Hostname=ZabbixServer

systemctl restart zabbix-agent
sudo netstat -tulpn|grep zabbix
firewall-cmd --add-port=10050/tcp --permanent
```
