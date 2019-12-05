## Домашнее задание
### Простая защита от DDOS

  Написать конфигурацию nginx, которая даёт доступ клиенту только с определенной cookie. Если у клиента её нет, нужно выполнить редирект на location, в котором кука будет добавлена, после чего клиент будет обратно отправлен (редирект) на запрашиваемый ресурс.

  Смысл: умные боты попадаются редко, тупые боты по редиректам с куками два раза не пойдут.

  Для выполнения ДЗ понадобятся:
1. https://nginx.org/ru/docs/http/ngx_http_rewrite_module.html
2. https://nginx.org/ru/docs/http/ngx_http_headers_module.html

## Домашняя работа

  Использована роль для развертывания nginx. Написан простейший конфиг сайта с проверкой наличия куки и редиректом в случае его отсутствия.

```bash
├── ansible.cfg
├── playbook.yml
├── README.md
├── roles
│   ├── epel
│   │   └── tasks
│   │       └── main.yml
│   └── nginx
│       ├── handlers
│       │   └── main.yml
│       ├── tasks
│       │   └── main.yml
│       └── templates
│           ├── index.html.j2
│           ├── nginx.conf.j2
│           └── sweet.conf.j2
├── staging
│   └── hosts
└── Vagrantfile
```

1. nginx.conf.j2 - конфиг nginx
2. sweet.conf.j2 - конфиг сайта с проверкой и редиректом
3. index.html.j2 - начальная страница

![nginx_cookie.png](https://github.com/alexshangin/otus/blob/master/lesson22/screen/nginx_cookie.png)