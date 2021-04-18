#!/bin/bash

# First argument: Client identifier
BASE_DIR="/opt/openvpn"
KEY_DIR="$BASE_DIR/openvpn-ca/keys"
OUTPUT_DIR="$BASE_DIR/client-configs/files"
BASE_CONFIG="$BASE_DIR/client-configs/base.conf"

cat ${BASE_CONFIG} \
    <(echo -e '<ca>') \
    ${KEY_DIR}/ca.crt \
    <(echo -e '</ca>\n<cert>') \
    ${KEY_DIR}/${1}.crt \
    <(echo -e '</cert>\n<key>') \
    ${KEY_DIR}/${1}.key \
    <(echo -e '</key>\n<tls-auth>') \
    ${KEY_DIR}/ta.key \
    <(echo -e '</tls-auth>') \
    > ${OUTPUT_DIR}/${1}.ovpn