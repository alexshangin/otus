### Первые шаги с Ansible
#### Подготовить стенд на Vagrant как минимум с одним сервером.

  На этом сервере используя Ansible необходимо развернуть nginx со следующими условиями:
- необходимо использовать модуль yum/apt
- конфигурационные файлы должны быть взяты из шаблона jinja2 с перемененными
- после установки nginx должен быть в режиме enabled в systemd
- должен быть использован notify для старта nginx после установки
- сайт должен слушать на нестандартном порту - 8080, для этого использовать переменные в Ansible

* Сделать все это с использованием Ansible роли

### Домашняя работа
#### Основная часть

- ansible/  - практическая работа по развертыванию nginx через playbook. после развертывания nginx слушается на [http://192.168.11.150:8080/](http://192.168.11.150:8080/)
- [ansible/ansible.png](https://github.com/alexshangin/otus/blob/master/lesson09/ansible/ansible.png) - скринт nginx на развернутом стенде

#### Запуск стенда.
После **vagrant up** нужно проверить порт ssh, указанный в **ansible/staging/hosts**
```bash
vagrant up
ansible-playbook playbooks/nginx.yml
```

```bash
ansible
├── ansible.cfg
├── epel.yml
├── playbooks
│   └── nginx.yml
├── staging
│   └── hosts
├── templates
│   └── nginx.conf.j2
└── Vagrantfile
```
#### Дополнительная работа

- ansible_role/ - развертывание nginx с использованием ролей. после развертывания nginx слушается на [http://192.168.11.151:8080/](http://192.168.11.151:8080/)
- [ansible_role/ansible_role.png](https://github.com/alexshangin/otus/blob/master/lesson09/ansible/ansible_role.png) - скринт nginx на развернутом стенде

#### Запуск стенда.
После **vagrant up** нужно проверить порт ssh, указанный в **ansible_role/staging/hosts**
```bash
vagrant up
ansible-playbook playbook.yml
```

```bash
ansible_role/
├── ansible.cfg
├── playbook.yml
├── provision
│   └── playbook.yml.old
├── roles
│   ├── epel
│   │   └── tasks
│   │       └── main.yml
│   └── nginx
│       ├── handlers
│       │   └── handlers.yml
│       ├── tasks
│       │   └── main.yml
│       └── templates
│           └── nginx.conf.j2
├── staging
│   └── hosts
├── Vagrantfile
└── vars
    └── nginxrole.yml
```
