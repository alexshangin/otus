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



!!! wp
https://hub.docker.com/_/wordpress
$ docker run --name some-wordpress -p 8080:80 -d wordpress

!!! nodejs
https://hub.docker.com/_/node
https://github.com/nodejs/docker-node/blob/master/README.md#how-to-use-this-image
https://hub.docker.com/r/nodeshift/centos7-s2i-nodejs
http://wd5.ru/nodejs/resheno-sh-1-cross-env-not-found/
https://github.com/nodejs/nodejs.org
https://github.com/nodejs/node
https://github.com/puppeteer/puppeteer
https://codeburst.io/build-a-weather-website-in-30-minutes-with-node-js-express-openweather-a317f904897b

!!!django
https://hub.docker.com/_/django
!!!
https://hub.docker.com/r/camandel/django-wiki
docker run -d -P --name=django-wiki camandel/django-wiki
https://github.com/gothinkster/django-realworld-example-app

!!!react
https://medium.com/@tiangolo/react-in-docker-with-nginx-built-with-multi-stage-docker-builds-including-testing-8cc49d6ec305
https://github.com/mrcoles/node-react-docker-compose
https://medium.com/@xiaolishen/develop-in-docker-a-node-backend-and-a-react-front-end-talking-to-each-other-5c522156f634
https://github.com/zackferrofields/docker-nginx-react


https://forums.docker.com/t/docker-compose-yml-services-for-nginx/52562
http://drach.pro/blog/linux/item/141-wordpress-docker-ubuntu
https://www.howtoforge.com/tutorial/dockerizing-wordpress-with-nginx-and-php-fpm/?__cf_chl_captcha_tk__=df4d74d57fa333492880d426d1f7fb7e278c53b6-1579529094-0-Aav_QoA72YCW1QgKXB8_rEh5qDLXYLkeM-aMdrcmZCVNATS4lLgUkWl9Ds080CBTaY6382Ya67hY8dgyIkBDPHwe-PqfWbga-KFcqT7bOjq_hW1ICx21TJ-PoOZesIy2a7hrBLIhE4FB25MA8_9bTmUsp8xifdIXMvgMz_K8NLI4c-TRiLOUcx3qTTMWXN4tGS1ZlIj_90c50m0aX0SOF48YKJHzPYwRmQ_Zo_xTJDsBmw-UjouNOlmIeqshWpCpeSDyHglAn5hhhXpH2GZy7csy-ico_meCSa0PY013UxI76oRcCbUiD5iXAOz27VL4oBDyxrRYmvLPLnfS5AawEEuFNxNOFz3Vx38ci0DmfOxRFj5D8OKZ1LnXvWc2S869ag

https://medium.com/swlh/wordpress-deployment-with-nginx-php-fpm-and-mariadb-using-docker-compose-55f59e5c1a
