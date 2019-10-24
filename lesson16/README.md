Подключимся для проверки к FreeIPA - WebUI, создадим пользователя и запросим его group и user ID:

![check_of](https://github.com/kyourselfer/OTUS_LinuxAdmin201804/blob/master/lesson18_ldap_freeipa/ldap_auth.gif)

Для подключения  `sudo ssh -N -L 443:127.0.0.1:443 vagrant@127.0.0.1 -p 2203` (в hosts `127.0.0.1	localhost ipaserver.otus.local`)


Домашнее задание
LDAP
1. Установить FreeIPA
2. Написать playbook для конфигурации клиента
3. *Настроить авторизацию по ssh-ключам

Домашняя работа

Написана роль для:
1. Развертывания сервера
2. Развертывания клиента и ввода его в домен
3. Добавление нового пользователя, с возможность авторизации по ssh-ключам.

  Для подключения под доменному имени к админке нужно добавить на хосте в /etc/hosts ip-адрес сервера, в нашем случае 192.168.11.161

  Авторизация на сервере и клиенте по ключам: [ssh_key_enter,png](https://github.com/alexshangin/otus/tree/master/lesson16/ssh_key_enter.png)

  Web ipa-server: [web_ipaserver.png](https://github.com/alexshangin/otus/tree/master/lesson16/web_ipaserver.png)
