FROM centos:latest

COPY mongodb-3.2.repo /etc/yum.repos.d/mongo-3.2.repo
ADD db-setup.sh /tmp/db-setup.sh
ADD db-setup.js /tmp/db-setup.js

RUN chmod +x /tmp/db-setup.sh
RUN chmod +x /tmp/db-setup.js

RUN yum update -y \
&& yum -y install mongodb-org \
&& yum clean all

CMD ["/tmp/db-setup.sh"]