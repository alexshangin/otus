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

  Настраиваем аудит, следящий за изменением конфигов nginx  

```bash
cat /etc/audit/rules.d/audit.rules
## nginx configurations
-w /etc/nginx/ -p wa -k nginx
```
```bash

```

- все критичные логи с web должны собираться и локально и удаленно  

```bash

if $syslogseverity-text == "crit" then {
        action(type="omfwd"
                Target="192.168.1.1"
                Port="514"
                Protocol="udp")
		action(type="omfile"
                File="/var/log/crit.log")
}




```
- все логи с nginx должны уходить на удаленный сервер (локально только критичные)  

В конфиг nginx.
```bash
access_log syslog:server=192.168.1.1,facility=local7,tag=nginx_acess,severity=info;
error_log syslog:server=192.168.1.1,facility=local7,tag=nginx_error,severity=info;
error_log /var/log/nginx/error.log crit;
```
- логи аудита уходят ТОЛЬКО на удаленную систему  

```bash
# в syslog.conf
args = LOG_INFO LOG_LOCAL6

# в rsyslog.conf
*.info;mail.none;authpriv.none;cron.none;local6.none                /var/log/messages

if $programname == "audispd" then {
        action(type="omfwd"
                Target="192.168.1.1"
                Port="514"
                Protocol="udp")
}

```

2 **развернуть еще машину elk**  
```bash
>curl 192.168.255.5:9200
{
  "name" : "log2",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "hT-nGL_uT1uCNKyFbc_CnA",
  "version" : {
    "number" : "6.3.2",
    "build_flavor" : "default",
    "build_type" : "rpm",
    "build_hash" : "053779d",
    "build_date" : "2018-07-20T05:20:23.451332Z",
    "build_snapshot" : false,
    "lucene_version" : "7.3.1",
    "minimum_wire_compatibility_version" : "5.6.0",
    "minimum_index_compatibility_version" : "5.0.0"
  },
  "tagline" : "You Know, for Search"
}
```
![kibana](https://i.imgur.com/KKdloke.png)

- и таким образом настроить 2 центральных лог системы elk И какую либо еще  

В первой задаче создан один лог-сервер (rsyslog). Во второй задаче создан elk-сервер. Таким образом всего 2 лог-сервера.

- в elk должны уходить только логи нжинкса  

```bash
template(name="nginxAccessTemplate" type="string" string="%msg%\n")

if $programname == "nginx_access" or $programname == "nginx_error" then {
        action(type="omfwd"
                        Target="192.168.255.5"
                        Port="9600"
                        Protocol="udp"
                template="nginxAccessTemplate")
}
```
- во вторую систему все остальное  

Настройки из пункта 1.  
