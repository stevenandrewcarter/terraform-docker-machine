#!/usr/bin/env bash
set -x
set -e

install_org_certs() {
    # Install CA Bundle for the Organization
    docker-machine ssh $1 'sudo mkdir -p /var/lib/boot2docker/certs'
    docker-machine scp sbsa_ca_bundle.pem $1:/home/docker
    docker-machine ssh $1 "sudo mv sbsa_ca_bundle.pem /var/lib/boot2docker/certs/"
    docker-machine restart $1
}

install() {
    docker-machine ssh $1 "sudo mkdir -p /etc/pki/tls/certs"
    docker-machine ssh $1 "sudo mkdir -p /etc/pki/tls/private"
    docker-machine scp ca.pem $1:/home/docker
    docker-machine ssh $1 "sudo mv /home/docker/ca.pem /etc/pki/tls/certs/sb_ca_bundle.pem"
    docker-machine scp $1-key.pem $1:/home/docker
    docker-machine scp $1-cert.pem $1:/home/docker
    docker-machine ssh $1 "sudo mv /home/docker/$1-key.pem /etc/pki/tls/private/key.pem"
    docker-machine ssh $1 "sudo mv /home/docker/$1-cert.pem /etc/pki/tls/certs/cert.pem"
}

generate() {
    ip=`docker-machine ip $1`
    openssl genrsa -out $1-key.pem 4096
    openssl req -subj "/CN=$1" -sha256 -new -key $1-key.pem -out server.csr
    echo subjectAltName = DNS:$1,IP:${ip},IP:127.0.0.1 >> extfile.cnf
    echo extendedKeyUsage = serverAuth >> extfile.cnf
    openssl x509 -req -passin pass:$2 \
        -days 365 -sha256 -in server.csr -CA ca.pem -CAkey ca-key.pem \
        -CAcreateserial -out $1-cert.pem -extfile extfile.cnf
    rm extfile.cnf
    rm server.csr
}

generate $1 $2
install $1
