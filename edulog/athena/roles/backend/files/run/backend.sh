#!/bin/bash
sudo java \
  -Dspring.datasource.url=jdbc:postgresql://${DB_HOST}:5432/Athena \
  -Dspring.rabbitmq.host=${QUEUE_HOST} \
  -Dspring.rabbitmq.username=${QUEUE_USER} \
  -Dspring.rabbitmq.password=${QUEUE_PASS} \
  -jar -XX:+UseG1GC -Xms256m -Xmx1024m /opt/athena/src/RoutingServer.jar
