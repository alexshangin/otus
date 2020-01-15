http://pawamoy.github.io/2018/02/01/docker-compose-django-postgres-nginx.html
https://github.com/Pawamoy/docker-nginx-postgres-django-example
### start
docker-compose build
docker-compose run --rm djangoapp hello/manage.py collectstatic --no-input'
docker-compose up
### or start
docker-compose run --rm djangoapp /bin/bash -c "cd hello; ./manage.py collectstatic"


https://www.haikson.com/programmirovanie/python/django-nginx-gunicorn-postgresql-docker/
docker-compose build
docker-compose up -d
