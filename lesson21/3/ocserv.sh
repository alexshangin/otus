#! /usr/bin/env bash
yum install -y epel-release
yum install -y ocserv.x86_64 mc vim
mkdir /etc/ocserv/cert
cp /vagrant/ca.tmpl /etc/ocserv/cert/ca.tmpl
cp /vagrant/server.tmpl /etc/ocserv/server.tmpl
cp /vagrant/ocserv.conf /etc/ocserv/ocserv.conf
cd /etc/ocserv/cert/
certtool --generate-privkey --outfile ca-key.pem
certtool --generate-self-signed --load-privkey ca-key.pem --template ca.tmpl --outfile ca-cert.pem
certtool --generate-privkey --outfile server-key.pem
certtool --generate-certificate --load-privkey server-key.pem --load-ca-certificate ca-cert.pem --load-ca-privkey ca-key.pem --template /etc/ocserv/server.tmpl --outfile server-cert.pem
mkdir /etc/ocserv/ssl/
cp ca-cert.pem server-key.pem server-cert.pem /etc/ocserv/ssl/
touch /etc/ocserv/passwd
echo 12345678 | ocpasswd -c /etc/ocserv/passwd -g default otus
systemctl start ocserv
systemctl enable ocserv
systemctl status ocserv
