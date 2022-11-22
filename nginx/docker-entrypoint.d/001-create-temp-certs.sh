#!/bin/sh

domains=$SERVER_NAME
rsa_key_size=4096
email=$DAPP_SMTP_DEFAULT_FROM # Adding a valid address is strongly recommended
staging=0 # Set to 1 if you're testing your setup to avoid hitting request limits

echo "### Creating dummy certificate for $domains ..."
path="/etc/letsencrypt/live/$domains"
mkdir -p $path
openssl req -x509 -nodes -newkey rsa:$rsa_key_size -days 1\
    -keyout "$path/privkey.pem" \
    -out "$path/fullchain.pem" \
    -subj '/CN=localhost'
echo "done"