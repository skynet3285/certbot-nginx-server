#!/bin/sh
set -e

while :; do
    certbot renew --webroot --webroot-path=/var/www/certbot --preferred-challenges http
    sleep 12h
done
