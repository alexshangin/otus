#!/bin/bash

systemctl start firewalld
firewall-cmd --add-protocol=vrrp --permanent
firewall-cmd --add-service=http --permanent
firewall-cmd --add-port=8080/tcp --permanent
firewall-cmd --reload


