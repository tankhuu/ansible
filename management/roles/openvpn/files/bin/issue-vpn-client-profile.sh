#!/bin/bash

org=$1
username=$2
email=$3
password=$4

client="${username}-${org}"

if [ $# -ne 4 ]; then
    echo $0: usage: issue-vpn-client-profile org username email password
    exit 1
fi

# Check if user exists
getent passwd ${username}
if [ $? -eq 0 ]; then
  echo "User exists! Update password & re-upload profile for user"
  echo -e "${password}\n${password}" | sudo passwd ${username}
  /usr/local/bin/reupload-profile $username $client
  exit 0
fi

echo "Create user profile"
# Build client key
/usr/local/bin/build-vpn-client-key $client

# Build client profile
/usr/local/bin/build-vpn-client-profile $client

# Create local user & rsa key
/usr/local/bin/gen-user-sshkey $username $email $password

# Upload profile to s3
/usr/local/bin/upload-profile-to-s3 $client $username