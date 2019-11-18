## Домашнее задание
### Docker, docker-compose, dockerfile

  Создайте свой кастомный образ nginx на базе alpine. После запуска nginx должен отдавать кастомную страницу (достаточно изменить дефолтную страницу nginx)
1. Определите разницу между контейнером и образом
2. Можно ли в контейнере собрать ядро?

  Собранный образ необходимо запушить в docker hub и дать ссылку на ваш репозиторий.

### Что должно быть Dockerfile:
```bash
FROM image name
RUN apt update -y && apt upgrade -y
COPY или ADD filename /path/in/image
EXPOSE portopenning
CMD or ENTRYPOINT or both
#не забываем про разницу между COPY и ADD
#or - одна из опций на выбор
```

Задание со * (звездочкой)
Создайте кастомные образы nginx и php, объедините их в docker-compose.
После запуска nginx должен показывать php info.
Все собранные образы должны быть в docker hub

## Домашняя работа

1. Определите разницу между контейнером и образом.
Контейнеры, в отличии от образов виртуальных машин, не являются полноценной виртуальной средой, так как они делят общее запущенное ядро одной физической машины.

2. Можно ли в контейнере собрать ядро?
Нет, тк контейнер - это изолированные процессы, запущеные на хосте.

  Ссылка на репозиторий docker hub: https://cloud.docker.com/repository/registry-1.docker.io/alexsius/otus

1. Кастомный образ nginx на базе alpine.
```bash
docker pull alexsius/otus:nginxv1
docker run -d -p 80:80 -p 443:443  alexsius/otus:nginxv1
curl 127.0.0.1
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>HTML5</title>
</head>
<body>
    Server is online
    <p>Create by Alex Shangin</p>
</body>
</html>
```
![1.nginx.png](https://github.com/alexshangin/otus/blob/master/lesson13/1.nginx.png)

2. Были созданы 2 кастомных образа на базе alpine: **nginx - alexsius/otus:nginx_compose** и **php-fpm -alexsius/otus:fpm_compose**. Они объединены в docker-compose.yml
```bash
cat docker-compose.yml 
version: '2'

services:
 fpm:
  image: alexsius/otus:fpm_compose
 nginx:
  image: alexsius/otus:nginx_compose
  ports:
   - 80:80
   - 443:443
```
  Для запуска используем **docker-compose up**  или с ключом **-d**, для запуска в режиме демона. После перехода по ссылке **http://127.0.0.1/index.php** увидим информацию о php.

![2.nginx_php.png](https://github.com/alexshangin/otus/blob/master/lesson13/2.nginx_php.png)
