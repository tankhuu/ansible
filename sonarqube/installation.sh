#!/bin/bash -xe

src_dir="/opt/sonarqube"

# Install prerequisites
echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" | sudo tee  /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
apt update
apt install -y awscli tree apt-transport-https openjdk-11-jre openjdk-11-jdk postgresql-12 nginx unzip tree

# Setup Database
sudo adduser --system --no-create-home --group --disabled-login sonarqube
########################################################################
  create database sonarqube;
  create user sonar;
  alter user sonar with password '6GiIX0aMLNrM';
  GRANT ALL PRIVILEGES ON DATABASE sonarqube to sonar;
  \c sonarqube
  GRANT USAGE ON SCHEMA public TO sonar;
  GRANT ALL PRIVILEGES ON SCHEMA public TO sonar;
  GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO sonar;
  GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO sonar;
########################################################################
echo "host    all    all    0.0.0.0/0    md5" >> /etc/postgresql/12/main/pg_hba.conf
echo "listen_addresses = '*'" >> /etc/postgresql/12/main/postgresql.conf
systemctl restart postgresql
systemctl enable postgresql


wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.3.1.34397.zip
unzip sonarqube-*.zip

sudo mkdir -p /opt/sonarqube
sudo chown ubuntu: /opt/sonarqube
cd /opt
chown -R sonarqube:sonarqube /opt/sonarqube
cd /opt/sonarqube
cd sonarqube/conf/
vi sonar.properties
########################################################################

########################################################################
vi /etc/systemd/system/sonarqube.service
########################################################################

########################################################################
ll /opt/sonarqube/bin/linux-x86-64/sonar.sh
########################################################################

########################################################################

service sonarqube start
service sonarqube status
systemctl enable sonarqube
curl http://127.0.0.1:9000

cd /opt/sonarqube/elasticsearch
vi config/jvm.options
########################################################################

########################################################################
vi /etc/security/limits.conf
########################################################################

########################################################################
vi /etc/sysctl.conf
########################################################################

########################################################################
sysctl -w vm.max_map_count=262144
sysctl -w vm.max_map_count=262144
sysctl -w fs.file-max=65536
ulimit -n 65536
ulimit -u 4096

apt install nginx
vi /etc/nginx/sites-enabled/sonarqube
########################################################################

########################################################################
cd /etc/nginx/sites-enabled/
rm default
nginx -t
systemctl restart nginx
vi /etc/nginx/nginx.conf
########################################################################

########################################################################


vi /etc/nginx/sites-enabled/sonarqube
server {
    listen      80;
    server_name sonar.athena-nonprod.com;

    access_log  /var/log/nginx/sonar.access.log;
    error_log   /var/log/nginx/sonar.error.log;

    proxy_buffers 16 64k;
    proxy_buffer_size 128k;
    client_max_body_size 10M;

    location / {
        proxy_pass  http://127.0.0.1:9000;
        proxy_next_upstream error timeout invalid_header http_500 http_502 http_503 http_504;
        proxy_redirect off;

        proxy_set_header    Host            $host;
        proxy_set_header    X-Real-IP       $remote_addr;
        proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header    X-Forwarded-Proto http;
    }
}


# Cleanup
rm -rf sonarqube-*
