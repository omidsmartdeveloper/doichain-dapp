#!/bin/sh

domains=($SERVER_NAME)
rsa_key_size=4096
data_path="./data/certbot"
email=$DAPP_SMTP_DEFAULT_FROM # Adding a valid address is strongly recommended
staging=0 # Set to 1 if you're testing your setup to avoid hitting request limits

apt update
apt install openssl 

echo "### Creating dummy certificate for $domains ..."
path="/etc/letsencrypt/live/$domains"
mkdir -p "$data_path/conf/live/$domains"
# docker compose run --rm --entrypoint "\
openssl req -x509 -nodes -newkey rsa:$rsa_key_size -days 1\
    -keyout '$path/privkey.pem' \
    -out '$path/fullchain.pem' \
    -subj '/CN=localhost'" certbot
    
#echo
#echo 'entry point was ${SERVER_NAME} with DAPP_PORT ${DAPP_PORT} running' > /tmp/was-running-${SERVER_NAME}.txt
#envsubst '${SERVER_NAME} ${DAPP_PORT}' < /etc/nginx/nginx.conf.template > /etc/nginx/conf.d/${SERVER_NAME}.conf
#data_path=/etc/letsencrypt
#mkdir -p "$data_path/conf"
#curl -s https://raw.githubusercontent.com/certbot/certbot/0.29.x/certbot-nginx/certbot_nginx/options-ssl-nginx.conf > "$data_path/conf/options-ssl-nginx.conf"
#curl -s https://raw.githubusercontent.com/certbot/certbot/1.32.x/certbot/certbot/ssl-dhparams.pem > "$data_path/conf/ssl-dhparams.pem"
#echo 'running nginx now and reload every 6 hours'
#while :; do sleep 6h & wait ${!}; nginx -s reload; done & nginx -g "daemon off;"

exec "$@"