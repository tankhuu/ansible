#!/bin/bash
sudo java -jar -XX:+UseG1GC -Xms256m -Xmx1024m /opt/athena/src/PlannedRollover.jar
