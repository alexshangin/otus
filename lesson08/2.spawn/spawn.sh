#!/usr/bin/env bash

# добавим реп и установим пакеты
install_spawn(){
yes | yum install -y epel-release && \
yes | yum install -y spawn-fcgi \
php \
php-cli \
mod_fcgid \
httpd
}

# раскоментим последние 2 строки в конфиге
edit_config(){
sed -e 's/^.//' /etc/sysconfig/spawn-fcgi | tail -3  >> /etc/sysconfig/spawn-fcgi
}

# создадим unit
create_spawnunit(){
printf '
[Unit]
Description=Spawn-fcgi startup service by Otus
After=network.target

[Service]
Type=simple
PIDFile=/var/run/spawn-fcgi.pid
EnvironmentFile=/etc/sysconfig/spawn-fcgi
ExecStart=/usr/bin/spawn-fcgi -n $OPTIONS
KillMode=process

[Install]
WantedBy=multi-user.target
' > /etc/systemd/system/spawn-fcgi.service
}

# стартуем
start_unit(){
systemctl start spawn-fcgi
}

main(){
install_spawn
edit_config
create_spawnunit
start_unit
}

[[ "$0" == "$BASH_SOURCE" ]] && main "$@"