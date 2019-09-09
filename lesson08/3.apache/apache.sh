#!/usr/bin/env bash

yes | yum install -y httpd

sed -i "s#.*EnvironmentFile=/etc/sysconfig/httpd.*#EnvironmentFile=/etc/sysconfig/httpd-%I#g" /usr/lib/systemd/system/httpd.service

echo 'OPTIONS=-f conf/first.conf' > /etc/sysconfig/httpd-first
echo 'OPTIONS=-f conf/second.conf' > /etc/sysconfig/httpd-second

cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/first.conf
cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/second.conf

echo 'PidFile /var/run/httpd-first.pid' >> /etc/httpd/conf/first.conf
echo 'PidFile /var/run/httpd-second.pid' >> /etc/httpd/conf/second.conf
sed -i "s#.*Listen 80.*#Listen 8080#g" /etc/httpd/conf/second.conf

systemctl start httpd@first
systemctl start httpd@second

ss -tnulp | grep httpd