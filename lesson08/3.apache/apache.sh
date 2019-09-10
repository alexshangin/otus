#!/usr/bin/env bash
# Apache2 double config start
install_apache2(){
yes | yum install -y httpd
}

create_unit(){
cp /usr/lib/systemd/system/httpd.service /usr/lib/systemd/system/httpd@.service
sed -i "s#.*EnvironmentFile=/etc/sysconfig/httpd.*#EnvironmentFile=/etc/sysconfig/httpd-%I#g" /usr/lib/systemd/system/httpd@.service
}

create_environment(){
echo 'OPTIONS=-f conf/first.conf' > /etc/sysconfig/httpd-first
echo 'OPTIONS=-f conf/second.conf' > /etc/sysconfig/httpd-second
}

create_apache2_config(){
#first conf port 80
cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/first.conf
echo 'PidFile /var/run/httpd-first.pid' >> /etc/httpd/conf/first.conf
#second conf port 8080
cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/second.conf
echo 'PidFile /var/run/httpd-second.pid' >> /etc/httpd/conf/second.conf
sed -i "s#.*Listen 80.*#Listen 8080#g" /etc/httpd/conf/second.conf
}

start_apache2(){
systemctl start httpd@first
systemctl start httpd@second
}

listen_port(){
ss -tnulp | grep httpd
}

main(){
install_apache2
create_unit
create_environment
create_apache2_config
start_apache2
listen_port
}

[[ "$0" == "$BASH_SOURCE" ]] && main "$@"