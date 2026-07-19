#!/bin/sh
set -e

CERT_DIR=/etc/ssl/private
CRT=/etc/ssl/certs/selfsigned.crt
KEY=${CERT_DIR}/selfsigned.key

mkdir -p ${CERT_DIR}

if [ ! -f "$KEY" ] || [ ! -f "$CRT" ]; then
  echo "Generating self-signed certificate for local testing..."
  openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -subj "/CN=${DOMAIN_NAME:-localhost}" \
    -keyout "$KEY" -out "$CRT"
fi

nginx -g 'daemon off;'
