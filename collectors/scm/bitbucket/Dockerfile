FROM openjdk:8-jre

VOLUME ["/hygieia/logs", "/certs"]

RUN mkdir /hygieia/config 
RUN mkdir /bitbucket-certs

EXPOSE 8080

ENV PROP_FILE /hygieia/config/application.properties
ENV CACERTS /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/cacerts
WORKDIR /hygieia

COPY target/*.jar /hygieia
COPY docker/properties-builder.sh /hygieia/

CMD ./properties-builder.sh &&\
  keytool -import -noprompt -alias public -file /bitbucket-certs/bitbucket.cer -keystore bitbucketstore -storepass 123456 \
  && java -Djava.security.egd=file:/dev/./urandom -jar *.jar --spring.config.location=$PROP_FILE