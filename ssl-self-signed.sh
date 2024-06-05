#! /bin/bash

# Inspired by: https://devopscube.com/create-self-signed-certificates-openssl/
# Usage: ssl-self-signed.sh my-fancy-server.dev.localhost [./output/dir/where/rootCA/would/be/reused]

DOMAIN=$1
OUT_DIR=$2

if [ -z "$OUT_DIR" ] ; then
  OUT_DIR="./"
fi

mkdir -p $OUT_DIR

if [ -z "$DOMAIN" ]
then
  echo "Error: No domain name argument provided"
  echo "Usage: Provide a domain name as an argument"
  exit 1
fi

# Create root CA & Private key if not exists
if [ -e ${OUT_DIR}/rootCA.key ] ; then
  echo "Root CA will be used: ${OUT_DIR}/rootCA.key"
else
  openssl req -x509 \
            -sha256 -days 3560 \
            -nodes \
            -newkey rsa:2048 \
            -subj "/CN=dev.gavluk.com/C=DE/L=Berlin" \
            -keyout "${OUT_DIR}/rootCA.key" -out "${OUT_DIR}/rootCA.crt"
  echo "Root CA key and certificate just created: ${OUT_DIR}/rootCA.key, ${OUT_DIR}/rootCA.crt"
fi

# Generate Private key
openssl genrsa -out "${OUT_DIR}/${DOMAIN}.key" 2048
echo "Server private key is generated: ${OUT_DIR}/${DOMAIN}.key"

# Create csf conf
CSR_CONF=$(mktemp --suffix _csr.conf)
cat > "${CSR_CONF}" <<EOF
[ req ]
default_bits = 2048
prompt = no
default_md = sha256
req_extensions = req_ext
distinguished_name = dn

[ dn ]
C = UA
ST = Lviv
L = Lviv
O = GAVLUK
OU = GAVLUK Dev
CN = ${DOMAIN}

[ req_ext ]
subjectAltName = @alt_names

[ alt_names ]
DNS.1 = ${DOMAIN}

EOF
echo "Certificate request configuration temp file just created: ${CSR_CONF}"

# create CSR request using private key
openssl req -new -key "${OUT_DIR}/${DOMAIN}.key" -out "${OUT_DIR}/${DOMAIN}.csr" -config "${CSR_CONF}"
echo "Certificate request for server is created: ${OUT_DIR}/${DOMAIN}.csr"

# Create a external config file for the certificate
CERT_CONF=$(mktemp --suffix _cert.conf)
cat > "${CERT_CONF}" <<EOF

authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = ${DOMAIN}

EOF
echo "External certificate config temp file just created: ${CERT_CONF}"

# Create SSl with self signed CA
openssl x509 -req \
    -in "${OUT_DIR}/${DOMAIN}.csr" \
    -CA "${OUT_DIR}/rootCA.crt" -CAkey "${OUT_DIR}/rootCA.key" \
    -CAcreateserial -out "${OUT_DIR}/${DOMAIN}.crt" \
    -days 3650 \
    -sha256 -extfile "${CERT_CONF}"
echo "Server certificate signed by ${OUT_DIR}/rootCA.key and saved as ${OUT_DIR}/${DOMAIN}.crt"
