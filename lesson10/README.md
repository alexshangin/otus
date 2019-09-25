### Домашнее задание
#### PAM

1. Запретить всем пользователям, кроме группы admin логин в выходные(суббота и воскресенье), без учета праздников
2. Дать конкретному пользователю права рута

### Домашняя работа
#### Закрепить знания по PAM linux

  Написан playbook и playbook_role. Provisioning добавлен в Vagrantfile. В переменных **vars/main.yml** можно указать имя пользователя, его пароль, группу, оболочку, создание домашней директории и добавление в su.

1. Реализован запрет входа всем, кроме группы **admin** в выходные дни. Используется проверка по группе в переменных и модуль **pam_time**
2. Если в параметре **use_sudo** указано **yes**, пользоваетель при входе может использовать **sudo -i** без ввода пароля. Кроме этого можно просто добавить пользователя в группу **wheel**

```bash
├── playbook
│   ├── provisioning
│   │   ├── playbook.yml
│   │   └── vars
│   │       └── main.yml
│   └── Vagrantfile
│
│
├── playbook_role
│   ├── provisioning
│   │   ├── ansible.cfg
│   │   ├── playbook.yml
│   │   ├── roles
│   │   │   ├── addusers
│   │   │   │   └── tasks
│   │   │   │       └── main.yml
│   │   │   ├── limits
│   │   │   │   └── tasks
│   │   │   │       └── main.yml
│   │   │   ├── sshd
│   │   │   │   ├── handlers
│   │   │   │   │   └── main.yml
│   │   │   │   └── tasks
│   │   │   │       └── main.yml
│   │   │   └── toroot
│   │   │       └── tasks
│   │   │           └── main.yml
│   │   ├── staging
│   │   │   └── hosts
│   │   └── vars
│   │       └── main.yml
│   └── Vagrantfile
│
│
└── README.md
```