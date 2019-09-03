FROM centos:centos7

RUN yum install -y redhat-lsb-core wget rpmdevtools rpm-build createrepo gcc sed openssl-devel zlib-devel pcre-devel
RUN cd /root
RUN wget https://nginx.org/packages/centos/7/SRPMS/nginx-1.16.1-1.el7.ngx.src.rpm
RUN wget https://www.openssl.org/source/latest.tar.gz
RUN rpm -i nginx-1.16.1-1.el7.ngx.src.rpm
RUN tar -xvf latest.tar.gz
RUN yum-builddep -y rpmbuild/SPECS/nginx.spec
RUN tar -xvf latest.tar.gz
RUN sed -i "s#.*with-debug.*#    --with-openssl=/root/openssl-1.1.1c#g" rpmbuild/SPECS/nginx.spec
RUN rpmbuild -bb rpmbuild/SPECS/nginx.spec
RUN yum localinstall -y rpmbuild/RPMS/x86_64/nginx-1.16.1-1.el7.ngx.x86_64.rpm
RUN systemctl start nginx
RUN mkdir /usr/share/nginx/html/repo
RUN yes | cp /root/rpmbuild/RPMS/x86_64/nginx-1.16.1-1.el7.ngx.x86_64.rpm /usr/share/nginx/html/repo
RUN wget https://www.percona.com/redir/downloads/percona-release/redhat/0.1-6/percona-release-0.1-6.noarch.rpm -O /usr/share/nginx/html/repo/percona-release-0.1-6.noarch.rpm
RUN createrepo /usr/share/nginx/html/repo/

COPY default.conf /etc/nginx/conf.d/default.conf

RUN systemctl reload nginx
RUN printf "[otus]\nname=otus-linux\nbaseurl=http://localhost/repo\ngpgcheck=0\nenabled=1\n" >> /etc/yum.repos.d/otus.repo
RUN yum install -y percona-release
RUN curl -a http://localhost/repo/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
