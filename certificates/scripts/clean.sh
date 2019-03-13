#!/usr/bin/env bash
if [[ $1 ]]
then
    rm -f $1-cert.pem
    rm -f $1-key.pem
fi
rm -f ca-key.pem
rm -f ca.pem
rm -f ca.srl