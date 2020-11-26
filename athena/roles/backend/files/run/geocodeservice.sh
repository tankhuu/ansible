#!/bin/bash
sudo java \
  -Dspring.datasource.url=jdbc:postgresql://${DB_HOST}:5432/Athena \
  -jar -XX:+UseG1GC -Xms256m -Xmx1024m /opt/athena/src/GeoCodeService.jar
