FROM nginx:1.26.2-alpine

RUN apk add --no-cache certbot

CMD ["/bin/sh", "-c", "nginx -g 'daemon off;' & trap exit TERM; while :; do certbot renew --webroot --webroot-path=/var/www/certbot --preferred-challenges http; sleep 12h & wait $${!}; done;"]
