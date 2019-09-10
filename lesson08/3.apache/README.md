## Домашнее задание
#### Systemd
#### Цель: Управление автозагрузкой сервисов происходит через systemd. Вместо cron'а тоже используется systemd. И много других возможностей. В ДЗ нужно написать свой systemd-unit.

3. Дополнить юнит-файл apache httpd возможностьб запустить несколько инстансов сервера с разными конфигами
  Задание необходимо сделать с использованием Vagrantfile и proviosioner shell (или ansible, на Ваше усмотрение) 

#### Решение:

  3. [apache.sh](https://github.com/alexshangin/otus/blob/master/lesson08/3.apache/apache.sh) - скрипт изменения unit-файла apache.

```bash
[root@otusrepo vagrant]# ss -tnulp | grep httpd
tcp    LISTEN     0      128      :::8080                 :::*                   users:(("httpd",pid=5762,fd=4),("httpd",pid=5761,fd=4),("httpd",pid=5760,fd=4),("httpd",pid=5759,fd=4),("httpd",pid=5758,fd=4),("httpd",pid=5757,fd=4))
tcp    LISTEN     0      128      :::80                   :::*                   users:(("httpd",pid=5755,fd=4),("httpd",pid=5754,fd=4),("httpd",pid=5753,fd=4),("httpd",pid=5752,fd=4),("httpd",pid=5751,fd=4),("httpd",pid=5750,fd=4))
```
