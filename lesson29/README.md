Домашнее задание
Vagrant стенд для NFS или SAMBA
NFS или SAMBA на выбор:

vagrant up должен поднимать 2 виртуалки: сервер и клиент
на сервер должна быть расшарена директория
на клиента она должна автоматически монтироваться при старте (fstab или autofs)
в шаре должна быть папка upload с правами на запись
- требования для NFS: NFSv3 по UDP, включенный firewall

* Настроить аутентификацию через KERBEROS
  Для подключения под доменному имени к админке нужно добавить на хосте в /etc/hosts ip-адрес сервера, в нашем случае 192.168.11.161

https://www.arus.ru/index.php/biblioteka/shpory/item/10569-nfs-server-v-domene-freeipa-2
https://www.arus.ru/index.php/biblioteka/shpory/item/10558-razgranichenie-prav-dostupa-na-fajlovom-servere-samba


https://codingbee.net/rhce/nfs-use-kerberos-to-control-nfs-access-on-centos-7
https://github.com/Sher-Chowdhury/CentOS7-kerberos-nfs-demo/tree/master/scripts

https://infrastructure.fedoraproject.org/cgit/ansible.git/tree/roles/nfs/client



https://github.com/splashx/ansible-krb5-server
https://www.lisenet.com/2016/kerberised-nfs-server-on-rhel-7/
