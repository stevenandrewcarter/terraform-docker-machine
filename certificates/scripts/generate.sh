#!/usr/bin/env bash
# Reference: https://docs.docker.com/engine/security/https/#create-a-ca-server-and-client-keys-with-openssl
set -e
echo "create_ca_certs:Creating Key"
openssl genrsa -aes256 -passout pass:$1 -out ca-key.pem 4096
echo "create_ca_certs:Creating Certificate"
openssl req \
        -passin pass:$1 \
        -new \
        -x509 \
        -subj "/C=ZA/ST=Gauteng/L=Johannesburg/O=Standard Bank/CN=local_cluster" \
        -days 365 \
        -key ca-key.pem \
        -sha256 \
        -out ca.pem
echo "create_ca_certs:Done!"