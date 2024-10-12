#!/bin/bash

# Generate certificates for TLS/kTLS
mkdir -p ../tls-app/certs ../ktls-app/certs

openssl req -new -newkey ec:<(openssl ecparam -name prime256v1) -days 365 -nodes -x509 \
    -keyout ../tls-app/certs/key.pem -out ../tls-app/certs/cert.pem -subj "/CN=localhost"

cp ../tls-app/certs/* ../ktls-app/certs/
