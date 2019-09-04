FROM centos:centos7

RUN yum install -y redhat-lsb-core wget rpmdevtools rpm-build createrepo gcc sed openssl-devel zlib-devel pcre-devel
RUN wget https://nginx.org/packages/centos/7/SRPMS/nginx-1.16.1-1.el7.ngx.src.rpm -O /root/nginx-1.16.1-1.el7.ngx.src.rpm
RUN wget https://www.openssl.org/source/latest.tar.gz -O /root/latest.tar.gz
RUN rpm -i /root/nginx-1.16.1-1.el7.ngx.src.rpm
RUN tar -xvf /root/latest.tar.gz -C /root
RUN yum-builddep -y /root/rpmbuild/SPECS/nginx.spec
RUN sed -i "s#.*with-debug.*#    --with-openssl=/root/openssl-1.1.1c#g" /root/rpmbuild/SPECS/nginx.spec
RUN rpmbuild -bb /root/rpmbuild/SPECS/nginx.spec
RUN yum localinstall -y /root/rpmbuild/RPMS/x86_64/nginx-1.16.1-1.el7.ngx.x86_64.rpm

COPY default.conf /etc/nginx/conf.d/default.conf

#RUN systemctl start nginx
RUN mkdir /usr/share/nginx/html/repo
RUN yes | cp /root/rpmbuild/RPMS/x86_64/nginx-1.16.1-1.el7.ngx.x86_64.rpm /usr/share/nginx/html/repo
RUN wget https://www.percona.com/redir/downloads/percona-release/redhat/0.1-6/percona-release-0.1-6.noarch.rpm -O /usr/share/nginx/html/repo/percona-release-0.1-6.noarch.rpm
RUN createrepo /usr/share/nginx/html/repo/
#RUN systemctl reload nginx
RUN printf "[otus]\nname=otus-linux\nbaseurl=http://localhost/repo\ngpgcheck=0\nenabled=1\n" >> /etc/yum.repos.d/otus.repo
#RUN yum install -y percona-release
#RUN curl -a http://localhost/repo/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
