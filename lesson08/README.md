## Домашнее задание
#### Systemd
#### Цель: Управление автозагрузкой сервисов происходит через systemd. Вместо cron'а тоже используется systemd. И много других возможностей. В ДЗ нужно написать свой systemd-unit.

1. Написать сервис, который будет раз в 30 секунд мониторить лог на предмет наличия ключевого слова. Файл и слово должны задаваться в /etc/sysconfig
2. Из epel установить spawn-fcgi и переписать init-скрипт на unit-файл. Имя сервиса должно так же называться.
3. Дополнить юнит-файл apache httpd возможностьб запустить несколько инстансов сервера с разными конфигами
4. *Скачать демо-версию Atlassian Jira и переписать основной скрипт запуска на unit-файл

  Задание необходимо сделать с использованием Vagrantfile и proviosioner shell (или ansible, на Ваше усмотрение) 

## Домашняя работа
### Цель: Закрепить знания по init-скриптам и unit-файлам в systemd

1. [1.watchlog/watchlog.sh](https://github.com/alexshangin/otus/blob/master/lesson08/1.watchlog/watchlog.sh) - скрипт создания сервиса для вагрант.
2. [2.spawn/spawn.sh](https://github.com/alexshangin/otus/blob/master/lesson08/2.spawn/spawn.sh) - скрипт изменения типа сервиса для вагрант.
3. [3.apache/apache.sh](https://github.com/alexshangin/otus/blob/master/lesson08/3.apache/apache.sh) - скрипт изменения unit-файла apache.
4. [4.jira/jira.service](https://github.com/alexshangin/otus/blob/master/lesson08/4.jira/jira.service) - unit-файл jira.
