#!/bin/bash
sudo java -jar -XX:+UseG1GC -Xms256m -Xmx1024m /opt/athena/src/ParentPortalIntegrationBatch.jar --spring.config.location=file:///opt/athena/config/pp-integration/application.properties
