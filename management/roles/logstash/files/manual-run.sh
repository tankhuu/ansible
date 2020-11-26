#!/bin/bash -ex
/usr/share/logstash/bin/logstash --path.settings /etc/logstash -f /etc/logstash/conf.d/shipper.conf