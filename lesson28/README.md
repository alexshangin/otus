http://pawamoy.github.io/2018/02/01/docker-compose-django-postgres-nginx.html
https://github.com/Pawamoy/docker-nginx-postgres-django-example
### start
docker-compose build
docker-compose run --rm djangoapp hello/manage.py collectstatic --no-input
docker-compose up
### or start
docker-compose run --rm djangoapp /bin/bash -c "cd hello; ./manage.py collectstatic"


https://www.haikson.com/programmirovanie/python/django-nginx-gunicorn-postgresql-docker/
docker-compose build
docker-compose up -d


https://medium.com/swlh/wordpress-deployment-with-nginx-php-fpm-and-mariadb-using-docker-compose-55f59e5c1a

# resources:
# http://www.ameyalokare.com/docker/2017/09/20/nginx-flask-postgres-docker-compose.html
# https://github.com/juggernaut/nginx-flask-postgres-docker-compose-example
# https://serverfault.com/questions/783806/docker-how-to-django-uwsgi-gunicorn-nginx/787402
# https://github.com/andrecp/django-tutorial-docker-nginx-postgres
# https://github.com/realpython/dockerizing-django
# http://ruddra.com/2016/08/14/docker-django-nginx-postgres/index.html
# https://stackoverflow.com/questions/32180589/docker-how-to-expose-a-socket-over-a-port-for-a-django-application

http://drach.pro/blog/linux/item/141-wordpress-docker-ubuntu


https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-docker-compose

https://tutos.readthedocs.io/en/latest/source/ndg.html
