### Домашнее задание
#### PostgreSQL
- Настроить hot_standby репликацию с использованием слотов
- Настроить правильное резервное копирование

Для сдачи работы присылаем ссылку на репозиторий, в котором должны обязательно быть Vagranfile и плейбук Ansible, конфигурационные файлы postgresql.conf, pg_hba.conf и recovery.conf, а так же конфиг barman, либо скрипт резервного копирования. Команда "vagrant up" должна поднимать машины с настроенной репликацией и резервным копированием. Рекомендуется в README.md файл вложить результаты (текст или скриншоты) проверки работы репликации и резервного копирования.

### Домашняя работа
Для запуска стенда используем команду **vagrant up**, после чего получим развернутую базу данных с реплик и резервным копированием. Используются 3 ноды: **master, slave и barman**

**Добавим тестовую бд otus**
```bash
postgres=# CREATE DATABASE otus;
CREATE DATABASE
postgres=# \l
                                  List of databases
   Name    |  Owner   | Encoding |   Collate   |    Ctype    |   Access privileges   
-----------+----------+----------+-------------+-------------+-----------------------
 otus      | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 otuslandb | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 postgres  | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 template0 | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
           |          |          |             |             | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
           |          |          |             |             | postgres=CTc/postgres
(5 rows)
```
**Проверим добавление на slave**
```bash
postgres=# \l
                                  List of databases
   Name    |  Owner   | Encoding |   Collate   |    Ctype    |   Access privileges   
-----------+----------+----------+-------------+-------------+-----------------------
 otus      | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 otuslandb | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 postgres  | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 template0 | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
           |          |          |             |             | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
           |          |          |             |             | postgres=CTc/postgres
(5 rows)

```
**логинимся на barman**
```bash
[root@barman /]# barman switch-xlog --force --archive master
The WAL file 000000010000000000000005 has been closed on server 'master'
Waiting for the WAL file 000000010000000000000005 from server 'master' (max: 30 seconds)
Processing xlog segments from streaming for master
	000000010000000000000005

[root@barman /]# barman check master
Server master:
	PostgreSQL: OK
	is_superuser: OK
	PostgreSQL streaming: OK
	wal_level: OK
	replication slot: OK
	directories: OK
	retention policy settings: OK
	backup maximum age: OK (no last_backup_maximum_age provided)
	compression settings: OK
	failed backups: OK (there are 0 failed backups)
	minimum redundancy requirements: OK (have 0 backups, expected at least 0)
	pg_basebackup: OK
	pg_basebackup compatible: OK
	pg_basebackup supports tablespaces mapping: OK
	systemid coherence: OK (no system Id stored on disk)
	pg_receivexlog: OK
	pg_receivexlog compatible: OK
	receive-wal running: OK
	archive_mode: OK
	archive_command: OK
	archiver errors: OK

[root@barman /]# barman backup master
Starting backup using postgres method for server master in /var/lib/barman/master/base/20200206T003156
Backup start at LSN: 0/6000060 (000000010000000000000006, 00000060)
Starting backup copy via pg_basebackup for 20200206T003156

[root@barman vagrant]# barman switch-wal --archive master
The WAL file 000000010000000000000004 has been closed on server 'master'
Waiting for the WAL file 000000010000000000000004 from server 'master' (max: 30 seconds)
Processing xlog segments from streaming for master
	000000010000000000000004

[root@barman vagrant]# barman check master
Server master:
	PostgreSQL: OK
	is_superuser: OK
	PostgreSQL streaming: OK
	wal_level: OK
	replication slot: OK
	directories: OK
	retention policy settings: OK
	backup maximum age: OK (no last_backup_maximum_age provided)
	compression settings: OK
	failed backups: OK (there are 0 failed backups)
	minimum redundancy requirements: OK (have 0 backups, expected at least 0)
	pg_basebackup: OK
	pg_basebackup compatible: OK
	pg_basebackup supports tablespaces mapping: OK
	systemid coherence: OK (no system Id stored on disk)
	pg_receivexlog: OK
	pg_receivexlog compatible: OK
	receive-wal running: OK
	archive_mode: OK
	archive_command: OK
	archiver errors: OK

[root@barman vagrant]# barman status master
Server master:
	Description: Backup from master
	Active: True
	Disabled: False
	PostgreSQL version: 11.6
	Cluster state: in production
	pgespresso extension: Not available
	Current data size: 30.3 MiB
	PostgreSQL Data directory: /var/lib/pgsql/11/data
	Current WAL segment: 000000010000000000000005
	PostgreSQL 'archive_command' setting: barman-wal-archive barman master %p
	Last archived WAL: No WAL segment shipped yet
	Failures of WAL archiver: 273 (000000010000000000000001 at Thu Feb  6 18:43:46 2020)
	Passive node: False
	Retention policies: not enforced
	No. of available backups: 0
	First available backup: None
	Last available backup: None
	Minimum redundancy requirements: satisfied (0/0)

[root@barman vagrant]# barman backup master
Starting backup using postgres method for server master in /var/lib/barman/master/base/20200206T154411
Backup start at LSN: 0/5000060 (000000010000000000000005, 00000060)
Starting backup copy via pg_basebackup for 20200206T154411

[root@barman vagrant]# barman replication-status master
Status of streaming clients for server 'master':
  Current LSN on master: 0/7000060
  Number of streaming clients: 3

  1. Async standby
     Application name: walreceiver
     Sync stage      : 5/5 Hot standby (max)
     Communication   : TCP/IP
     IP Address      : 192.168.11.22 / Port: 49512 / Host: -
     User name       : replication
     Current state   : streaming (async)
     Replication slot: slot
     WAL sender PID  : 8763
     Started at      : 2020-02-06 17:12:05.405359+03:00
     Sent LSN   : 0/7000060 (diff: 0 B)
     Write LSN  : 0/7000060 (diff: 0 B)
     Flush LSN  : 0/7000060 (diff: 0 B)
     Replay LSN : 0/7000060 (diff: 0 B)

  2. Async WAL streamer
     Application name: barman_receive_wal
     Sync stage      : 3/3 Remote write
     Communication   : TCP/IP
     IP Address      : 192.168.11.23 / Port: 57940 / Host: -
     User name       : barman
     Current state   : streaming (async)
     Replication slot: barman
     WAL sender PID  : 8791
     Started at      : 2020-02-06 17:14:42.323402+03:00
     Sent LSN   : 0/7000060 (diff: 0 B)
     Write LSN  : 0/7000060 (diff: 0 B)
     Flush LSN  : 0/7000000 (diff: -96 B)

  3. Async WAL streamer
     Application name: barman_streaming_backup
     Sync stage      : 1/3 1-safe
     Communication   : TCP/IP
     IP Address      : 192.168.11.23 / Port: 57958 / Host: -
     User name       : barman
     Current state   : backup (async)
     WAL sender PID  : 9529
     Started at      : 2020-02-06 18:44:11.711886+03:00
```
