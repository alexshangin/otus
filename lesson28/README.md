## Домашнее задание
#### Собрать стенд с 3мя проектами на выбор
Варианты стенда:
nginx + php-fpm (laravel/wordpress) + python (flask/django) + js(react/angular)
nginx + java (tomcat/jetty/netty) + go + ruby
можно свои комбинации

Реализации на выбор
- на хостовой системе через конфиги в /etc
- деплой через docker-compose

Для усложнения можно попросить проекты у коллег с курсов по разработке

К сдаче примается
- vagrant стэнд с проброшенными на локалхост портами
- каждый порт на свой сайт
- через нжинкс

## Домашняя работа

#### Реализция 1.
Docker. Реализовано на полностью готовых образах docker-hub. wordpress + django-wiki + wikijs
Для запуска выполняем команду **docker-compose up**

![django_8081_pp.png](https://github.com/alexshangin/otus/blob/master/lesson28/screen/docker/django_8081_pp.png)
![nodejs_8082_pp.png](https://github.com/alexshangin/otus/blob/master/lesson28/screen/docker/nodejs_8082_pp.png)
![php-fpm_8080_pp.png](https://github.com/alexshangin/otus/blob/master/lesson28/screen/docker/php-fpm_8080_pp.png)

#### Реализция 2.
Docker2. Реализовано на базовых образах docker-hub, со сборкой проектов через Dockerfile. wordpress + hello-world на python + nodejs
Для запуска выполняем команду **docker-compose up --build**

![python_8082.png](https://github.com/alexshangin/otus/blob/master/lesson28/screen/docker2/python_8082.png)
![nodejs_8081.png](https://github.com/alexshangin/otus/blob/master/lesson28/screen/docker2/nodejs_8081.png)
![php-fpm_8080.png](https://github.com/alexshangin/otus/blob/master/lesson28/screen/docker2/php-fpm_8080.png)

#### Реализция 3.
Vagrant. wordpress(8080) + nodejs(8081) + hello-world на python(8082)
Для запуска выполняем команду **vagrant up**
