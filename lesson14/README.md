### Домашнее задание
#### Настраиваем центральный сервер для сбора логов

в вагранте поднимаем 2 машины web и log
на web поднимаем nginx
на log настраиваем центральный лог сервер на любой системе на выбор
- journald
- rsyslog
- elk
настраиваем аудит следящий за изменением конфигов нжинкса

все критичные логи с web должны собираться и локально и удаленно
все логи с nginx должны уходить на удаленный сервер (локально только критичные)
логи аудита должны также уходить на удаленную систему

* развернуть еще машину elk
и таким образом настроить 2 центральных лог системы elk И какую либо еще
в elk должны уходить только логи нжинкса
во вторую систему все остальное

### Домашняя работа

### Домашнее задание
#### Настраиваем центральный сервер для сбора логов

  Сервером логов был выбран rsyslog. Для автоматического развертыания систем по основному заданию и заданию со * написаны роли.

Настраиваем аудит, следящий за изменением конфигов nginx:
```bash
cat /etc/audit/rules.d/audit.rules
## nginx configurations
-w /etc/nginx/ -p wa -k nginx
```

Все критичные логи с web должны собираться и локально и удаленно. Добавляем свое правило в otus.conf:
```bash
if $syslogseverity-text == "crit" then {
        action(type="omfwd"
                Target="192.168.11.143"
                Port="514"
                Protocol="udp")
		action(type="omfile"
                File="/var/log/crit.log")
}
```

Все логи с nginx должны уходить на удаленный сервер (локально только критичные). Изменяем nginx.conf:
```bash
access_log syslog:server=192.168.11.143,facility=local7,tag=nginx_acess,severity=info;
error_log syslog:server=192.168.11.143,facility=local7,tag=nginx_error,severity=info;
error_log /var/log/nginx/error.log crit;
```

Логи аудита должны также уходить на удаленную систему:
```bash
# в syslog.conf
args = LOG_INFO LOG_LOCAL6

# в rsyslog.conf
*.info;mail.none;authpriv.none;cron.none;local6.none                /var/log/messages

# в otus.conf
if $programname == "audispd" then {
        action(type="omfwd"
                Target="192.168.11.143"
                Port="514"
                Protocol="udp")
		action(type="omfile"
                File="/var/log/audit/audit.log")
}
```

Развернуть еще машину elk.
В elk должны уходить только логи nginx:
```bash
# в otus.conf
template(name="nginxAccessTemplate" type="string" string="%msg%\n")

if $programname == "nginx_access" or $programname == "nginx_error" then {
        action(type="omfwd"
                        Target="192.168.11.145"
                        Port="9600"
                        Protocol="udp"
                template="nginxAccessTemplate")
}
```

Добавим правила для logstash:
```bash
# input.conf
input
{
 syslog
 {
 type => syslog
 port => 9600
 codec => json
 }
}
# output.conf
output
{
 elasticsearch { hosts => ["127.0.0.1:9200"] index => "nginx"}
}
# filter.conf
filter
{
 json
 {
 source => "message"
 remove_field => ["priority","severity","facility"]
 }
}
```

Создаем индекс для логов nginx в Kibana:

![1](https://github.com/alexshangin/otus/blob/master/lesson14/screen/create_index_1.png)
![2](https://github.com/alexshangin/otus/blob/master/lesson14/screen/create_index_2.png)

Curl на внешний и внутренний адреса elastic:
![3][https://github.com/alexshangin/otus/tree/master/lesson14/screen/curl_elastic.png]
![4][https://github.com/alexshangin/otus/tree/master/lesson14/screen/curl_elastic_2.png]

Netstat c сервера:
![5][https://github.com/alexshangin/otus/tree/master/lesson14/screen/elastic_9200.png]
![6][https://github.com/alexshangin/otus/tree/master/lesson14/screen/kibana_5601.png]
![7][https://github.com/alexshangin/otus/tree/master/lesson14/screen/rsyslog_9600.png]

Kibana:
![8][https://github.com/alexshangin/otus/tree/master/lesson14/screen/index_nginx.png]
![9][https://github.com/alexshangin/otus/tree/master/lesson14/screen/nginx_logs.png]

Nginx audit logs:
![10][https://github.com/alexshangin/otus/tree/master/lesson14/screen/nginx_audit.png]
