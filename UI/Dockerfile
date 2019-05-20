FROM centos:latest

USER root

RUN yum update -y \
&& yum install -y wget unzip curl vim python-setuptools openssl sed \
&& wget http://nginx.org/packages/centos/7/x86_64/RPMS/nginx-1.14.0-1.el7_4.ngx.x86_64.rpm \
&& rpm -iv nginx-1.14.0-1.el7_4.ngx.x86_64.rpm \
&& yum -y install nginx

COPY docker/default.conf /etc/nginx/conf.d/default.conf.templ
COPY docker/conf-builder.sh /usr/bin/conf-builder.sh
COPY dist /usr/share/nginx/html

RUN chown -R nginx:nginx /usr/share/nginx/html/

EXPOSE 80 443

CMD conf-builder.sh &&\
  nginx -g "daemon off;"
