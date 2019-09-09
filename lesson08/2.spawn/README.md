## Домашнее задание
#### Systemd
#### Цель: Управление автозагрузкой сервисов происходит через systemd. Вместо cron'а тоже используется systemd. И много других возможностей. В ДЗ нужно написать свой systemd-unit.

2. Из epel установить spawn-fcgi и переписать init-скрипт на unit-файл. Имя сервиса должно так же называться.
  Задание необходимо сделать с использованием Vagrantfile и proviosioner shell (или ansible, на Ваше усмотрение) 

#### Решение:

  [spawn.sh](https://github.com/alexshangin/otus/blob/master/lesson08/2.spawn/spawn.sh) - скрипт изменения типа сервиса для вагрант.

```bash
[root@otusrepo vagrant]# systemctl status spawn-fcgi.service 
● spawn-fcgi.service - Spawn-fcgi startup service by Otus
   Loaded: loaded (/etc/systemd/system/spawn-fcgi.service; disabled; vendor preset: disabled)
   Active: active (running) since Mon 2019-09-09 10:47:59 UTC; 31s ago
 Main PID: 5865 (php-cgi)
   CGroup: /system.slice/spawn-fcgi.service
           ├─5865 /usr/bin/php-cgi
           ├─5866 /usr/bin/php-cgi
           ├─5867 /usr/bin/php-cgi
           ├─5868 /usr/bin/php-cgi
           ├─5869 /usr/bin/php-cgi
           ├─5870 /usr/bin/php-cgi
           ├─5871 /usr/bin/php-cgi
           ├─5872 /usr/bin/php-cgi
           ├─5873 /usr/bin/php-cgi
           ├─5874 /usr/bin/php-cgi
           ├─5875 /usr/bin/php-cgi
           ├─5876 /usr/bin/php-cgi
           ├─5877 /usr/bin/php-cgi
           ├─5878 /usr/bin/php-cgi
           ├─5879 /usr/bin/php-cgi
           ├─5880 /usr/bin/php-cgi
           ├─5881 /usr/bin/php-cgi
           ├─5882 /usr/bin/php-cgi
           ├─5883 /usr/bin/php-cgi
           ├─5884 /usr/bin/php-cgi
           ├─5885 /usr/bin/php-cgi
           ├─5886 /usr/bin/php-cgi
           ├─5887 /usr/bin/php-cgi
           ├─5888 /usr/bin/php-cgi
           ├─5889 /usr/bin/php-cgi
           ├─5890 /usr/bin/php-cgi
           ├─5891 /usr/bin/php-cgi
           ├─5892 /usr/bin/php-cgi
           ├─5893 /usr/bin/php-cgi
           ├─5894 /usr/bin/php-cgi
           ├─5895 /usr/bin/php-cgi
           ├─5896 /usr/bin/php-cgi
           └─5897 /usr/bin/php-cgi

Sep 09 10:47:59 otusrepo systemd[1]: Started Spawn-fcgi startup service by Otus.
```