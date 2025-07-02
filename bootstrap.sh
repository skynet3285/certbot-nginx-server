#!/bin/sh

chown -R nginx:nginx /var/log/nginx
chown -R nginx:nginx /var/log/letsencrypt
chown -R nginx:nginx /etc/letsencrypt
chown -R nginx:nginx /var/www/certbot

# certbot
sh /renew-certbot.sh &

exec /docker-entrypoint.sh "$@"
