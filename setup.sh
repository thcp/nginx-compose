#!/bin/bash

set -e

source .env

GIT_ROOT="$(git rev-parse --show-toplevel)"

echo "Setting up $DOMAIN..."

mkdir -p "$GIT_ROOT/data/ssl/sites/$DOMAIN"
mkdir -p "$GIT_ROOT/data/www/$DOMAIN" ; cd $_ ; touch index.html

cp "$GIT_ROOT/conf/nginx/conf.d/default.conf.sample" "$GIT_ROOT/conf/nginx/conf.d/$DOMAIN.conf"
sed -i "s/DOMAIN/$DOMAIN/g" "$GIT_ROOT/conf/nginx/conf.d/$DOMAIN.conf"

echo "
Please install rng-utils to speedup OpenSSL/GnuPG Entropy before proceeding, this may take a while...
"
read -p "press any key to continue..."
#
time openssl dhparam -out "$GIT_ROOT/conf/nginx/ssl_conf/ssl-dhparams.pem" 4096
#
echo "
I'm using cloudflare , so you can find their guide here:

https://support.cloudflare.com/hc/en-us/articles/115000479507


Add your certificate and key to:
  $GIT_ROOT/data/ssl/sites/$DOMAIN/

Naming convention to follow:
  $GIT_ROOT/data/ssl/sites/$DOMAIN/key.key
  $GIT_ROOT/data/ssl/sites/$DOMAIN/cert.pem
"

read -p "press any key to continue...
"

echo "make sure to check your grade on SSL Labs, I bet a beer that you will get an A+
https://www.ssllabs.com/ssltest/analyze.html?d=$DOMAIN
"
docker-compose up -d 
