#!/bin/bash -xe

username=$1
client=$2
home_dir=/home/ubuntu/client-configs/files
ovpn_file=${home_dir}/${username}/${client}.ovpn
rsa_file=${home_dir}/${username}/${client}.pem
s3_tmp_bucket=edulog-athena-shorterm

aws s3 cp --acl public-read ${ovpn_file} s3://${s3_tmp_bucket}/vpn/
aws s3 cp --acl public-read ${rsa_file} s3://${s3_tmp_bucket}/vpn/
