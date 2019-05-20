#!/bin/bash

echo "Starting MongoDB Server"

# nohup /usr/bin/mongod &
nohup /usr/bin/mongod >> nohup.out 2>&1 &

echo "Waiting for Mongo DB Server"
# Wait for the Mongo Server to be started
/usr/bin/wait-for-it.sh localhost:27017 --timeout=0 -- echo "Mongo Server is started"

echo "Performing Setup Operations"
# Perform DB Setup
db-setup.sh

# Build Hygieia API
/hygieia-api/properties-builder.sh
nohup java -Djava.security.egd=file:/dev/./urandom -jar /hygieia-api/*.jar --spring.config.location=$HYGIEIA_API_PROP_FILE >> hygieia-api.out 2>&1 &

# Build Hygieia API Audit
/hygieia-api-audit/properties-builder.sh
nohup java -Djava.security.egd=file:/dev/./uandom -jar /hygieia-api-audit/*.jar --spring.config.location=$HYGIEIA_API_AUDIT_PROP_FILE >> hygieia-api-audit.out 2>&1 &

# Config Builder for UI
conf-builder.sh
/usr/bin/wait-for-it.sh localhost:8082 --timeout=0 -- echo "API Server is started"
nohup nginx -g "daemon off;" >> nginx.out 2>&1 &

tail -f hygieia-api.out & tail -f hygieia-api-audit.out & tail -f nginx.out