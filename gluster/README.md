# otus-gluster

# GlusterFS Distributed Filesystem Configuration

Создание файловой системы [GlusterFS](http://www.gluster.org/) на виртуальных машинах

##  Создание виртуальной машины

  1. Скачать и установить [VirtualBox](https://www.virtualbox.org/wiki/Downloads).
  2. Скачать и установить [Vagrant](http://www.vagrantup.com/downloads.html).
  3. [Mac/Linux only] Установить [Ansible](http://docs.ansible.com/ansible/latest/intro_installation.html).
  4. Установить роли ansible `ansible-galaxy install -r requirements.yml` 
  5. Запускаем `vagrant up` чтобы создать виртуальные машины и запустить конфигурацию

## Проверить что Gluster работает правильно следующими командами

    # Получить статус кластера. 
    $ ansible gluster -i inventory -a "gluster peer status" -b
    
    # Получить состояние тома (volume) кластера.
    ansible gluster -i inventory -a "gluster volume info" -b

Можно убедиться, что файлы реплицируются / распространяются правильно:

 1. Войдите на первый сервер: `vagrant ssh gluster1`
 2. Создайте файл в подключенном томе кластера: `sudo touch /mnt/gluster/test`
 3. Выйдите из первого сервера: `exit`
 4. Войдите на второй сервер: `vagrant ssh gluster2`
 5. Просмотрите содержимое каталога gluster: `ls /mnt/gluster`


Вы должны увидеть файл `test`, созданный на шаге 2; это означает, что Gluster работает правильно!

## Дополнительные настройки для управления кластером
  1. Добавление хостов кластера в файл /etc/hosts `ansible-playbook -i inventory  playbooks/hosts.yml`
  2. Установка и настройка Cluster Shell  
    `ansible-playbook -i inventory  playbooks/install_clush.yml`
  3. Проверка что hosts файл и Cluster Shell настроены и работают
    
    # Добавим ключ vagrant
    $ ssh-add ~/.vagrant.d/insecure_private_key 
    # Зайдем на хост с пробросом ключа
    $ vagrant ssh gluster1 -- -A 
    # Запустим команду на выполнение на всех узлах
    $ clush --hostfile=nodes uname

## Источники:
Проект использует роли из [Jeff Geerling](https://www.jeffgeerling.com/) as an example for [Ansible for DevOps](https://www.ansiblefordevops.com/).
