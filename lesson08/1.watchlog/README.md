## Домашнее задание
#### Systemd
#### Цель: Управление автозагрузкой сервисов происходит через systemd. Вместо cron'а тоже используется systemd. И много других возможностей. В ДЗ нужно написать свой systemd-unit.

1. Написать сервис, который будет раз в 30 секунд мониторить лог на предмет наличия ключевого слова. Файл и слово должны задаваться в /etc/sysconfig
  Задание необходимо сделать с использованием Vagrantfile и proviosioner shell (или ansible, на Ваше усмотрение) 

#### Решение:

1. [1.watchlog/watchlog.sh](https://github.com/alexshangin/otus/blob/master/lesson08/1.watchlog/watchlog.sh) - скрипт создания сервиса для вагрант.

  Для проверки сервиса используем команду **tail -f /var/log/messages**:

```bash
[root@otusrepo vagrant]# tail -f /var/log/messages 
Sep  8 22:25:06 localhost systemd: Started My watchlog service.
Sep  8 22:25:09 localhost systemd-logind: Removed session 4.
Sep  8 22:25:09 localhost systemd: Removed slice User Slice of vagrant.
Sep  8 22:26:30 localhost systemd: Starting My watchlog service...
Sep  8 22:26:30 localhost root: Sun Sep  8 22:26:30 UTC 2019: I found word, Master!
Sep  8 22:26:30 localhost systemd: Started My watchlog service.
```

  Сервис работает!