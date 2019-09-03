#!/usr/bin/env bash
yum install -y redhat-lsb-core wget rpmdevtools rpm-build createrepo gcc
cd /root
wget https://nginx.org/packages/centos/7/SRPMS/nginx-1.16.1-1.el7.ngx.src.rpm
wget https://www.openssl.org/source/latest.tar.gz
rpm -i nginx-1.16.1-1.el7.ngx.src.rpm
tar -xvf latest.tar.gz
yum-builddep -y rpmbuild/SPECS/nginx.spec
tar -xvf latest.tar.gz openssl/
sed -i "s#.*with-debug.*#    --with-openssl=/root/openssl-1.1.1c#g" rpmbuild/SPECS/nginx.spec
rpmbuild -bb rpmbuild/SPECS/nginx.spec
yum localinstall -y rpmbuild/RPMS/x86_64/nginx-1.16.1-1.el7.ngx.x86_64.rpm
systemctl start nginx
mkdir /usr/share/nginx/html/repo
yes | cp /root/rpmbuild/RPMS/x86_64/nginx-1.16.1-1.el7.ngx.x86_64.rpm /usr/share/nginx/html/repo
wget https://www.percona.com/redir/downloads/percona-release/redhat/0.1-6/percona-release-0.1-6.noarch.rpm -O /usr/share/nginx/html/repo/percona-release-0.1-6.noarch.rpm
createrepo /usr/share/nginx/html/repo/
cp /vagrant/default.conf /etc/nginx/conf.d/default.conf
systemctl reload nginx
printf "[otus]\nname=otus-linux\nbaseurl=http://localhost/repo\ngpgcheck=0\nenabled=1\n" >> /etc/yum.repos.d/otus.repo
yum install -y percona-release
curl -a http://localhost/repo/
