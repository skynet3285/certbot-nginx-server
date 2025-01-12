#!/bin/sh
set -e

# Base Image's Entrypoint
/docker-entrypoint.sh "$@" &

while :; do
    certbot renew --webroot --webroot-path=/var/www/certbot --preferred-challenges http
    sleep 12h
done