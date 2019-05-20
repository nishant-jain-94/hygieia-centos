FROM centos:latest

COPY mongodb-3.2.repo /etc/yum.repos.d/mongo-3.2.repo

RUN yum update -y \
&& yum -y install mongodb-org \
&& yum clean all

ENTRYPOINT ["/usr/bin/mongod"]
