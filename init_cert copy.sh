docker-compose run -d --service-ports --name temp-certbot-nginx-server --entrypoint \
    "/docker-entrypoint.sh" certbot-nginx-server nginx -g 'daemon off;'

docker-compose run --rm --name init-certbot --entrypoint "\
    certbot certonly \
    -d {YOUR_DOMAIN} \
    --email {YOUR_EMAIL} \
    --manual --preferred-challenges http \
    --server https://acme-v02.api.letsencrypt.org/directory \
    --force-renewal" certbot-nginx-server
echo

docker rm -f temp-certbot-nginx-server
