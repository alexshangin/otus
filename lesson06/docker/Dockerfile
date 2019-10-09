FROM centos:centos7
MAINTAINER Alex Shangin "alex.shangin.13@gmail.com"

ENV nginxver="1.16.1-1" \
    os="centos" \
    osver="7" \
    elver="7"

ENV percver="0.1-6"

RUN yum -y update && \
    yum clean all

RUN yum install -y \
    redhat-lsb-core \
    wget \
    rpmdevtools \
    rpm-build \
    createrepo \
    gcc \
    sed \
    openssl-devel \
    zlib-devel \
    pcre-devel

RUN groupadd nginx && \
    useradd --no-create-home nginx -g nginx

RUN wget https://nginx.org/packages/$os/$osver/SRPMS/nginx-$nginxver.el$elver.ngx.src.rpm -O /root/nginx-$nginxver.el$elver.ngx.src.rpm && \
    wget https://www.openssl.org/source/latest.tar.gz -O /root/latest.tar.gz

RUN rpm -i /root/nginx-$nginxver.el$elver.ngx.src.rpm && \
    tar -xvf /root/latest.tar.gz -C /root && \
    yum-builddep -y /root/rpmbuild/SPECS/nginx.spec && \
    sed -i "s#.*with-debug.*#    --with-openssl=/root/openssl-1.1.1d#g" /root/rpmbuild/SPECS/nginx.spec && \
    rpmbuild -bb /root/rpmbuild/SPECS/nginx.spec && \
    yum localinstall -y /root/rpmbuild/RPMS/x86_64/nginx-$nginxver.el$elver.ngx.x86_64.rpm && \
    mkdir -p /usr/share/nginx/html/repo

RUN rm /etc/nginx/conf.d/default.conf

COPY default.conf /etc/nginx/conf.d/default.conf

RUN cp /root/rpmbuild/RPMS/x86_64/nginx-$nginxver.el$elver.ngx.x86_64.rpm /usr/share/nginx/html/repo
RUN wget https://www.percona.com/redir/downloads/percona-release/redhat/$percver/percona-release-$percver.noarch.rpm -O /usr/share/nginx/html/repo/percona-release-$percver.noarch.rpm
RUN createrepo /usr/share/nginx/html/repo/

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]

#RUN printf "[otus]\nname=otus-linux\nbaseurl=http://localhost/repo\ngpgcheck=0\nenabled=1\n" >> /etc/yum.repos.d/otus.repo
