#!/bin/bash
sudo java \
  -Dtransactionhub.mongodb.host=${CACHE_HOST} \
  -Duser.mongodb.host=${CACHE_HOST} \
  -Dspring.rabbitmq.host=${QUEUE_HOST} \
  -Dspring.rabbitmq.username=${QUEUE_USER} \
  -Dspring.rabbitmq.password=${QUEUE_PASS} \
  -jar -XX:+UseG1GC -Xms256m -Xmx1024m /opt/athena/src/TransactionHUBV2.jar
