*** Домашнее задание
**** Настройка мониторинга
Настроить дашборд с 4-мя графиками:
1) память
2) процессор
3) диск
4) сеть

Настроить на одной из систем
- zabbix (использовать screen (комплексный экран))
- prometheus - grafana

Использование систем примеры которых не рассматривались на занятии
- список возможных систем был приведен в презентации

*** Домашняя работа

**** Разворачиваем PrometheusWithGrafana

Скрин основной страницы [grafana.png](https://github.com/alexshangin/otus/blob/master/lesson11/2.Prometheus/grafana.png)

За основу для выполнения задания был взят playbook из ссылки ниже и дописан под текущее задание.
https://github.com/MiteshSharma/PrometheusWithGrafana

В задании используется 4 вм:
1. alertmanager - менеджер уведомлений
2. grafana - веб-фронтенд к СУБД
3. prometheus - СУБД
4. prometheus_node_exporter - сервис, задача которого заключается в экспорте информации о машине в формате, понятном Prometheus’у

В качестве машины для сбора метрик использовался сервер Zabbix, запущенный в первой части домашней работы. Подключение производилось с помощью плагина.

```bash
├── ansible.cfg
├── grafana.png
├── inventory
├── playbook.yml
├── README.md
├── roles
│   ├── alertmanager
│   │   ├── files
│   │   │   └── alertmanager.yml
│   │   ├── handlers
│   │   │   └── main.yml
│   │   ├── tasks
│   │   │   └── main.yml
│   │   ├── templates
│   │   │   └── init.service.j2
│   │   └── vars
│   │       └── main.yml
│   ├── grafana
│   │   ├── handlers
│   │   │   └── main.yml
│   │   ├── README.md
│   │   ├── tasks
│   │   │   └── main.yml
│   │   ├── templates
│   │   │   ├── grafana.conf.j2
│   │   │   └── grafana.repo.j2
│   │   └── vars
│   │       └── main.yml
│   ├── prometheus
│   │   ├── files
│   │   │   └── alertrules.yml
│   │   ├── handlers
│   │   │   └── main.yml
│   │   ├── tasks
│   │   │   └── main.yml
│   │   ├── templates
│   │   │   ├── init.service.j2
│   │   │   └── prometheus.conf.j2
│   │   └── vars
│   │       └── main.yml
│   └── prometheus_node_exporter
│       ├── tasks
│       │   └── main.yml
│       ├── templates
│       │   └── init.service.j2
│       └── vars
│           └── main.yml
├── staging
│   └── hosts
├── tmp
│   └── PrometheusWithGrafana
└── Vagrantfile
```
