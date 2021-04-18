#!/bin/bash

#echo "ovpn & rsa files will be uploaded to s3 $1 and $2"
home_dir=/home/ubuntu/client-configs/files
ovpn_file=${home_dir}/$1.ovpn
rsa_file=${home_dir}/$2.pem
rsa_pub=${home_dir}/$2.pub
s3_bk_bucket="edulog-athena-backup"
s3_tmp_bucket="edulog-athena-shorterm"

aws s3 cp --acl public-read ${ovpn_file} s3://${s3_tmp_bucket}/vpn/
aws s3 cp --acl public-read ${rsa_file} s3://${s3_tmp_bucket}/vpn/

mkdir -p ${home_dir}/$2
mv ${ovpn_file} ${home_dir}/$2
mv ${rsa_file} ${home_dir}/$2
mv ${rsa_pub} ${home_dir}/$2

# Backup profiles to S3
cd ${home_dir}
aws s3 cp --recursive $2 s3://${s3_bk_bucket}/vpn/
