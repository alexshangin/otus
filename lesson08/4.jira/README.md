## Домашнее задание
#### Systemd
#### Цель: Управление автозагрузкой сервисов происходит через systemd. Вместо cron'а тоже используется systemd. И много других возможностей. В ДЗ нужно написать свой systemd-unit.

4. *Скачать демо-версию Atlassian Jira и переписать основной скрипт запуска на unit-файл

#### Решение:

    [jira.sh](https://github.com/alexshangin/otus/blob/master/lesson08/4.jira/jira.sh) - скрипт вагрант для загрузки jira.
    [jira.service](https://github.com/alexshangin/otus/blob/master/lesson08/4.jira/jira.service) - unit-файл.

1. Unit написан на основании анализа файлов /etc/rc.d/init.d/jira
2. При установке программы можно использовать установку как демона. При этом будет создан /run/systemd/generator.late/jira.service, который так же будет ссылаться на /etc/rc.d/init.d/jira
3. При анализе файлов в jira/bin был найден файл daemon.sh, с поддержкой команд start | stop | run | version, частично объединяющий в себе start-jira.sh и stop-jira.sh. Опция run - Start Tomcat without detaching from console. 
4. Так же на официальном комьюнити есть готовый пример unit файла.
