#!/bin/bash

docker volume create certs > /dev/null

rm -rf config
mkdir config

if [[ -z "${DOMAIN}" ]]; then
  read -p "Enter domain: " DOMAIN && export DOMAIN
fi

read -p "Enter E-Mail address: " EMAIL && export EMAIL

read -p "Enter Ionos API prefix: " PREFIX
read -p "Enter Ionos API secret: " SECRET

echo "$PREFIX.$SECRET" > credentials

(envsubst < templates/docker-compose.yml) > docker-compose.yml

echo "client_max_body_size 10G;" > config/uploadsize.conf
echo "proxy_request_buffering off;" > config/uploadsize.conf
