FROM centos:latest

USER root

VOLUME ["/hygieia/logs"]

RUN mkdir /hygieia/config \
 && yum update -y \
 && yum install -y java-1.8.0-openjdk

EXPOSE 8080

ENV PROP_FILE /hygieia/config/application.properties

WORKDIR /hygieia

COPY target/*.jar /hygieia
COPY docker/properties-builder.sh /hygieia/

CMD ./properties-builder.sh &&\
  java -Djava.security.egd=file:/dev/./urandom -jar *.jar --spring.config.location=$PROP_FILE