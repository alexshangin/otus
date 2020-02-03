# InnoDB cluster

Стенд для изучения InnoDB-кластера.

## Документация
https://docs.oracle.com/cd/E17952_01/mysql-5.7-en/mysql-innodb-cluster-using-router.html

https://docs.oracle.com/cd/E17952_01/mysql-5.7-en/mysql-innodb-cluster-production-deployment.html

## Запуск
Для запуска необходим вагрант. Выполняем ```vagrant up```. После окончания работы получается InnoDB-кластер из 3х нод, mysql-роутера и mysql-shell'a.


## Подключение к кластеру

Необходимо указать пароль пользователя `admin`

```mysql -u admin -p -P6446 -h 127.0.0.1```

- #### MySQL Classic protocol:

    - Чтение/Запись: ```<host>:6446```
    - Только чтение: ```<host>:6447```

- ####  MySQL X protocol (SSL):

    - Чтение/Запись: ```<host>:64460```
    - Только чтение: ```<host>:64470```

## Просмотр состояния
Необходимо указать пароль пользователя `admin`

```sudo mysqlsh --uri admin@node1 -e "dba.getCluster().status()"```

## Учетные данные

Учетные данные передаеются в ansible playbook через переменые. Актуальные значение можно увидеть в Vagrant-файле, так же они приведены ниже:
- пароль root'а ```mysql_root_password = "_SecretPass1"```
- администратор кластера ```mysql_admin_username = "admin"```
- пароль администратора  ```mysql_admin_password = "_AdminPassword2"```
- имя кластера ```cluster_name" = "clInnoDB"```
