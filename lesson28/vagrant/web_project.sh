#!/usr/bin/env bash

selinux(){
  setenforce 0
}

http(){
  yum erase -y httpd
}

epel(){
  yum install epel-release -y
}

base_soft(){
  yum install -y nginx wget mc
}

php56(){
cd ~
yes | yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum install -y yum-utils
yum-config-manager --enable remi-php56
yes | yum install -y php php-fpm php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo
cp /vagrant/www.conf /etc/php-fpm.d/www.conf
cp /vagrant/nginx.conf /etc/nginx/nginx.conf
wget https://ru.wordpress.org/latest-ru_RU.tar.gz
tar -xf latest-ru_RU.tar.gz
cp -r wordpress /var/www/html
systemctl start php-fpm
systemctl enable php-fpm
}

nodejs(){
  cd ~
  wget -qO- https://rpm.nodesource.com/setup_13.x | bash -
  yum install -y nodejs
  mkdir -p /var/www/html/sysmon
  cp /vagrant/server.js /var/www/html/sysmon/server.js
  npm install forever -g
  cd /var/www/html/sysmon/
  forever start server.js
}

python(){
  yum install -y install python-pip python-devel gcc
  mkdir /opt/myproject
  pip install virtualenv
  cd /opt/myproject
  virtualenv myprojectenv
  source myprojectenv/bin/activate
  pip install uwsgi
  cp /vagrant/wsgi.py /opt/myproject/wsgi.py
  cp /vagrant/myproject.ini /opt/myproject/myproject.ini
  deactivate
  cp /vagrant/uwsgi.service /etc/systemd/system/uwsgi.service
  systemctl start uwsgi.service
  systemctl enable uwsgi.service
}

restart_nginx(){
  systemctl restart nginx
  systemctl enable nginx
}

main(){
selinux
http
epel
base_soft
php56
nodejs
python
restart_nginx
}

[[ "$0" == "$BASH_SOURCE" ]] && main "$@"
