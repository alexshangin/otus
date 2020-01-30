## Домашнее задание
#### Vagrant стенд для NFS или SAMBA

NFS или SAMBA на выбор:
1. vagrant up должен поднимать 2 виртуалки: сервер и клиент
2. на сервер должна быть расшарена директория
3. на клиента она должна автоматически монтироваться при старте (fstab или autofs)
4. в шаре должна быть папка upload с правами на запись
5. требования для NFS: NFSv3 по UDP, включенный firewall

* Настроить аутентификацию через KERBEROS

## Домашняя работа

####  Vagrant стенд для NFS

Для запуска стенда **vagrant up**. Директория для монтирования /mnt/otus_share/

```bash
# переходим в директорию на сервере
[vagrant@master otus_share]$ cd /mnt/otus_share/
# пробуем создать файл от обычного пользователя - отказано в доступе
[vagrant@master otus_share]$ touch file.txt
touch: cannot touch 'file.txt': Permission denied
# пробуем от пользователя root - файл создается
[vagrant@master otus_share]$ sudo su
[root@master otus_share]# touch file.txt
[root@master otus_share]# exit
# переходим в директорию на сервере, доступную для записи
[vagrant@master otus_share]$ cd /mnt/otus_share/upload/
# пробуем создать файл от обычного пользователя - файл создается
[vagrant@master upload]$ touch file.txt
# смотрим список файлов
[vagrant@master upload]$ ls -la
total 0
drwxr-xr-x. 2 vagrant vagrant 22 Jan 30 08:40 .
drwxr-xr-x. 3 root    root    36 Jan 30 08:40 ..
-rw-rw-r--. 1 vagrant vagrant  0 Jan 30 08:40 file.txt

# переходим в директорию на клиенте
[vagrant@slave ~]$ cd /mnt/otus_share/
# пробуем создать файл от обычного пользователя - отказано в доступе
[vagrant@slave otus_share]$ touch file.txt
touch: cannot touch 'file.txt': Permission denied
# пробуем создать файл от пользователя root - отказано в доступе
[vagrant@slave otus_share]$ sudo su
[root@slave otus_share]# touch file.txt
touch: cannot touch 'file.txt': Permission denied
[root@slave otus_share]# exit
# переходим в примонтированную директорию, доступную для записи
[vagrant@slave otus_share]$ cd /mnt/otus_share/upload/
# пробуем создать файл от обычного пользователя - файл создается
[vagrant@slave upload]$ touch file.txt
# смотрим список файлов
[vagrant@slave upload]$ ls -la
total 0
drwxr-xr-x. 2 vagrant vagrant 22 Jan 30 08:40 .
drwxr-xr-x. 3 root    root    36 Jan 30 08:40 ..
-rw-rw-r--. 1 vagrant vagrant  0 Jan 30 08:41 file.txt
```
